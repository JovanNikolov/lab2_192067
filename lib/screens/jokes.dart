import 'package:flutter/material.dart';
import 'package:lab2_192067/services/api_services.dart';
import '../models/joke_model.dart';
import '../utils/capitalize.dart';
import '../widgets/joke/joke_back_button.dart';

class Jokes extends StatefulWidget{
  const Jokes({super.key});

  @override
  State<Jokes> createState() => _JokesState();
}

class _JokesState extends State<Jokes>{
  late Future<List<Joke>> futureJokes;
  String type = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as String;
    type = arguments;
    print("id: $type");
    if (type.isNotEmpty) {
      futureJokes = ApiServices.getJokesFromJokeAPI(type);
    }
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
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              final joke = jokes[index];
              return ListTile(
                title: Text(joke.setup),
                subtitle: Text(joke.punchline),
              );
            },
          );
        },
      ),
      floatingActionButton: const JokeBackButton(),
    );
  }
}