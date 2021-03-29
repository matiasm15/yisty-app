import 'package:flutter/material.dart';

import 'package:yisty_app/models/ingredient.dart';
import 'package:yisty_app/widgets/design/matching.dart';

class IngredientMatching extends StatelessWidget {
  const IngredientMatching({Key key, this.ingredient, this.icon = true, this.size = 24}) : super(key: key);

  final Ingredient ingredient;
  final bool icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    MatchingType type;

    if (ingredient.isPermitted) {
      type = MatchingType.good;
    } else if (ingredient.isDenied) {
      type = MatchingType.bad;
    } else {
      type = MatchingType.unknown;
    }

    return Matching(type: type, icon: icon, size: size);
  }
}
