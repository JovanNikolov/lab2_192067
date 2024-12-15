import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../widgets/type/type_grid.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> types = [];

  @override
  void initState() {
    super.initState();
    getJokeTypesFromAPI();
  }

  void getJokeTypesFromAPI() async {
    ApiServices.getJokeTypesFromJokeAPI().then((response) {
      List<String> data = List.from(json.decode(response.body));
      setState(() {
        types = data;
      });
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
        title: const Text("192067", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/random');
            },
            icon: const Icon(Icons.help_outline, color: Colors.white, size: 24),
          ),
        ],
      ),
      body: TypeGrid(types: types),
    );
  }
}