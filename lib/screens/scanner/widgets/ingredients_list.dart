import 'package:flutter/material.dart';

import 'package:yisty_app/models/ingredient.dart';
import 'package:yisty_app/screens/scanner/widgets/ingredient_matching.dart';

class IngredientsList extends StatelessWidget {
  const IngredientsList({Key key, this.ingredients}) : super(key: key);

  final List<Ingredient> ingredients;

  int sortValue(Ingredient ingredient) {
    if (ingredient.isPermitted) {
      return 1;
    } else if (ingredient.isDenied) {
      return -1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    ingredients.sort((Ingredient first, Ingredient second) {
      return sortValue(first).compareTo(sortValue(second));
    });

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ingredients.length,
      itemBuilder: (BuildContext context, int index) {
        final Ingredient ingredient = ingredients[index];

        return Card(
          child: ListTile(
            subtitle: IngredientMatching(ingredient: ingredient, icon: false, size: 20),
            title: Text(ingredient.capitalizeName),
          )
        );
      },
    );
  }
}