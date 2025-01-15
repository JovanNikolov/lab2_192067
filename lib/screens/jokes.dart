import 'package:flutter/material.dart';
import 'package:lab2_192067/services/api_services.dart';
import '../models/joke_model.dart';
import '../utils/capitalize.dart';
import '../widgets/joke/joke_back_button.dart';
import 'package:lab2_192067/utils/global_notifier.dart';
import 'package:provider/provider.dart';

class Jokes extends StatefulWidget{

  const Jokes({super.key});

  @override
  State<Jokes> createState() => _JokesState();
}

class _JokesState extends State<Jokes>{
  late Future<List<Joke>> futureJokes;
  String type = "";
  late Function(Joke) updateFavorite;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    final routeSettings = modalRoute?.settings;
    // print(routeSettings.toString());
    final arguments = routeSettings?.arguments as Map<String, dynamic>;

    if (arguments != null) {
      final args = arguments.map((key, value) => MapEntry(key as String, value));

      type = args['type'] as String;
      updateFavorite = args['updateFavorite'] as Function(Joke);

      print("Type: $type");

      if (type.isNotEmpty) {
        futureJokes = ApiServices.getJokesFromJokeAPI(type);
      }
    }
  }

  void toggleFavorite(Joke joke) {
    // print(joke.setup.toString());
    Provider.of<GlobalNotifier>(context, listen: false).updateFavoriteJokes(joke);
    updateFavorite(joke);
    setState(() {
      joke.isFavorite = !joke.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.white, size: 24)),
        title: Text('${capitalize(type)} Jokes', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: Colors.white, size: 24))],
      ),
      body: FutureBuilder<List<Joke>>(
        future: futureJokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No jokes found.'));
          }

          final jokes = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              final joke = jokes[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8),
                  title: Text(joke.setup,
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(joke.punchline),
                  leading: IconButton(
                    onPressed: () => toggleFavorite(joke),
                    color: joke.isFavorite ? Colors.yellow[800] : Colors.blue,
                    icon: Icon(Icons.sentiment_very_satisfied),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: const JokeBackButton(),
    );
  }
}