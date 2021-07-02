import 'package:flutter/material.dart';
import 'package:yisty_app/models/ingredient.dart';
import 'package:yisty_app/screens/scanner/widgets/ingredients_list.dart';
import 'package:yisty_app/screens/scanner/widgets/pending_product_page.dart';
import 'package:yisty_app/widgets/design/matching.dart';

class IngredientsInformation extends StatelessWidget {
  const IngredientsInformation({Key key, this.barcode, this.onFinish, this.ingredients}) : super(key: key);

  final List<Ingredient> ingredients;
  final void Function() onFinish;
  final String barcode;

  void onPendingProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => PendingProductPage(
            onFinish: onFinish,
            barcode: barcode
        ),
        fullscreenDialog: true,
      ),
    );
  }

  Widget _buildMatching() {
    final bool anyDenied = ingredients.any((Ingredient ingredient) => ingredient.isDenied);

    MatchingType type;

    if (anyDenied) {
      type = MatchingType.bad;
    } else {
      final bool anyUnknown = ingredients.any((Ingredient ingredient) => ingredient.isUnknown);

      if (anyUnknown) {
        type = MatchingType.unknown;
      } else {
        type = MatchingType.good;
      }
    }

    return Matching(type: type, size: 40, vertical: true);
  }

  String _descriptionText() {
    if (ingredients.length > 1) {
      return 'Se identificaron ${ingredients.length} ingredientes:';
    } else {
      return 'Se identificó un ingrediente:';
    }
  }

  Widget _buildList() {
    if (ingredients.isEmpty) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Text(_descriptionText()),
        Padding(
          child: IngredientsList(
            ingredients: ingredients
          ),
          padding: const EdgeInsets.only(top: 5, bottom: 50),
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: _buildMatching()
        ),
        _buildList(),
        ElevatedButton(
          child: const Text('Agregar producto a Yisty'),
          onPressed: () => onPendingProduct(context),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.undo),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Escanear otro producto')
                )
              ]
            ),
            onPressed: onFinish,
          )
        )
      ],
    );
  }
}