import 'package:flutter/cupertino.dart';
import 'package:lab2_192067/widgets/type/type_card.dart';

import '../../models/joke_model.dart';

class TypeGrid extends StatefulWidget {
  final List<String> types;
  final Function(Joke) updateFavorite;
  const TypeGrid({super.key, required this.types,required this.updateFavorite,});

  @override
  State<TypeGrid> createState() => _TypeGridState();
}

class _TypeGridState extends State<TypeGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(padding: const EdgeInsets.all(4),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        semanticChildCount: 250,
        childAspectRatio: 200/ 60,
        shrinkWrap: true,
        children: widget.types.map((type) => TypeCard(
            type: type,
            updateFavorite: widget.updateFavorite
        )).toList()
    );
  }
}