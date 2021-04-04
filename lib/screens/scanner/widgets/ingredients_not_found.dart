import 'package:flutter/material.dart';

import 'package:yisty_app/screens/scanner/widgets/suggestion_list_title.dart';

class IngredientsNotFound extends StatelessWidget {
  const IngredientsNotFound({Key key, this.onFinish, this.onRetry}) : super(key: key);

  final void Function() onFinish;
  final void Function() onRetry;

  Widget _buildSuggestions() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
            children: const <Widget>[
              Text(
                  'Puedes intentarlo de nuevo si lo deseas. Tené en cuenta los siguientes consejos'
                      ' al tomar la imagen:'
              ),
              SuggestionListTile(title: Text('Intenta que el texto sea lo mas legible posible.')),
              SuggestionListTile(title: Text('Se deben ver todos los ingredientes del producto.')),
              SuggestionListTile(title: Text('Hazlo desde un lugar con buena iluminación.'))
            ]
        )
    );
  }

  Widget _buildIcon() {
    return Stack(
      children: <Widget>[
        Icon(Icons.no_photography_outlined, size: 100, color: Colors.grey[700])
      ]
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
                _buildIcon(),
                const Text(
                    'No pudimos identificar los ingredientes en la imagen',
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
            child: const Text('Escanear de nuevo'),
            onPressed: onRetry,
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