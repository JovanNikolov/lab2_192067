import 'dart:collection';

import 'package:flutter/material.dart';
import '../../models/joke_model.dart';
import '../../utils/capitalize.dart';

class TypeCard extends StatelessWidget {
  final String type;
  final Function(Joke) updateFavorite;
  const TypeCard({super.key, required this.type, required this.updateFavorite,});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.red[50],
          onTap: () {
            Map<String, dynamic> args = HashMap();
            args["type"] = type;
            args["updateFavorite"] = updateFavorite;
            if (type == "Favorite"){
              Navigator.pushNamed(context, '/favorite',
                arguments: args);
            }
            else{
              Navigator.pushNamed(context, '/jokes',
                arguments: args);}
          },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red.withOpacity(0.8), width: 2),
                borderRadius: BorderRadius.circular(10)
            ),
            child:
              Text(capitalize(type), style: const TextStyle(
                  color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600
              ),)
            ,
          )
      ),
    );
  }
}