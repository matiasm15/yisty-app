import 'package:flutter/material.dart';

import 'package:yisty_app/models/ingredient.dart';
import 'package:yisty_app/screens/scanner/widgets/ingredients_information.dart';
import 'package:yisty_app/screens/scanner/widgets/ingredients_not_found.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/widgets/design/loading_widget.dart';

class ScannerIngredientsStep extends StatelessWidget {
  const ScannerIngredientsStep({Key key, this.barcode, this.onFinish, this.onRetry, this.ingredientsFuture}) : super(key: key);

  final void Function() onFinish;
  final void Function() onRetry;
  final Future<List<Ingredient>> ingredientsFuture;
  final String barcode;

  Widget _buildError(AsyncSnapshot<List<Ingredient>> snapshot) {
    if (snapshot.error is AppException) {
      return AlertPage(
          message: snapshot.error.toString()
      );
    }

    throw snapshot.error;
  }

  Widget _buildIngredients(AsyncSnapshot<List<Ingredient>> snapshot) {
    final List<Ingredient> ingredients = snapshot.data;

    if (ingredients.isEmpty) {
      return IngredientsNotFound(onRetry: onRetry, onFinish: onFinish);
    } else {
      return IngredientsInformation(barcode: barcode, ingredients: ingredients, onFinish: onFinish);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ingredient>>(
        future: ingredientsFuture,
        builder: (_ , AsyncSnapshot<List<Ingredient>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return _buildError(snapshot);
            }

            return _buildIngredients(snapshot);
          }

          return LoadingWidget();
        }
    );
  }
}
