import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/joke_model.dart';

class ApiServices{
  static Future<http.Response> getJokeTypesFromJokeAPI() async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/types"));
    return response;
  }
  
  static Future<List<Joke>> getJokesFromJokeAPI(String type) async{
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten'));
    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      var data = jsonDecode(response.body) as List;
      print("data $data");
      return data.map((joke) => Joke.fromJson(joke)).toList();
    }
    else{
      throw Exception("Failed to load data!");
    }
  }

  static Future<Joke> getJokesFromRandomJokeAPI() async{
    final response = await http.get(Uri.parse('https://xn--official-joke-pi-6dn.appspot.com/random_joke'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Joke.fromJson(data);
    }
    else{
      throw Exception("Failed to load data!");
    }
  }
}