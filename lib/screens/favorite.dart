import 'package:flutter/material.dart';
import 'package:lab2_192067/utils/global_notifier.dart';
import 'package:provider/provider.dart';
import '../widgets/joke/joke_back_button.dart';
import '../models/joke_model.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  void toggleFavorite(Joke joke) {
    Provider.of<GlobalNotifier>(context, listen: false).updateFavoriteJokes(joke);
    setState(() {
      joke.isFavorite = !joke.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Joke> favoriteJokes = Provider.of<GlobalNotifier>(context, listen: false).globalFavoriteJokes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.white, size: 24)),
        title: Text('Favorite Jokes', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: Colors.white, size: 24))],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: favoriteJokes.length,
          itemBuilder: (context, index) {
            final joke = favoriteJokes[index];
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
        ),
      floatingActionButton: const JokeBackButton(),
    );
  }
}
