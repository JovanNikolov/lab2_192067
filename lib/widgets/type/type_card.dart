import 'package:flutter/material.dart';
import '../../utils/capitalize.dart';

class TypeCard extends StatelessWidget {
  final String type;

  const TypeCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.red[50],
          onTap: () => {
            Navigator.pushNamed(context, '/jokes',
                arguments: type)
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