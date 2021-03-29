import 'package:flutter/material.dart';

import 'package:yisty_app/screens/scanner/widgets/suggestion_list_title.dart';

class BarcodeNotFound extends StatelessWidget {
  const BarcodeNotFound({Key key, this.barcode, this.onFinish, this.onIngredientsScan}) : super(key: key);

  final String barcode;
  final void Function() onFinish;
  final void Function() onIngredientsScan;

  Widget _buildSuggestions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: const <Widget>[
          Text(
              'Pero aún puedes escanear los ingredientes del producto para determinar'
                  ' si el producto es apto para vos. Tené en cuenta los siguientes consejos'
                  ' al tomar la imagen:'
          ),
          SuggestionListTile(title: Text('Intenta que el texto sea lo mas legible posible.')),
          SuggestionListTile(title: Text('Se deben ver todos los ingredientes del producto.')),
          SuggestionListTile(title: Text('Hazlo desde un lugar con buena iluminación.'))
        ]
      )
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 50),
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search_off_outlined, size: 100, color: Colors.grey[700]),
            const Text(
              'No encontramos el producto que escaneaste',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18)
            ),
            _buildSuggestions()
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildMessage(context),
        ElevatedButton(
          child: const Text('Escanear ingredientes'),
          onPressed: onIngredientsScan,
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
                          child: Text('Volver a escanear código de barras')
                      )
                    ]
                ),
                onPressed: onFinish,
            )
        )
      ]
    );
  }
}