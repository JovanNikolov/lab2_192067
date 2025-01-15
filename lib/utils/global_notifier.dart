import 'package:flutter/material.dart';
import '../models/joke_model.dart';

class GlobalNotifier extends ChangeNotifier {
  List<Joke> _favoriteJokes = [];
  List<Joke> get globalFavoriteJokes => _favoriteJokes;

  void updateFavoriteJokes(Joke joke) {

    joke.isFavorite = !joke.isFavorite;
    if (joke.isFavorite) {
      _favoriteJokes.add(joke);
    } else {
      _favoriteJokes.removeWhere((j) => j == joke);
    }
    notifyListeners();
  }
}
