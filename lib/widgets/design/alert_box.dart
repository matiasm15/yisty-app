import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({Key key, this.message, this.onClose}) : super(key: key);

  final String message;
  final Function onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).errorColor,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.error_outline),
          ),
          Expanded(
            child: AutoSizeText(
              message,
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => onClose(),
            ),
          )
        ],
      ),
    );
  }
}