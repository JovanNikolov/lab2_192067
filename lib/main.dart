import 'package:flutter/material.dart';
import 'package:lab2_192067/screens/home.dart';
import 'package:lab2_192067/screens/jokes.dart';
import 'package:lab2_192067/screens/random.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vicoteka',
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/jokes': (context) => const Jokes(),
        '/random': (context) => const RandomJoke(),
      },
    );
  }
}
