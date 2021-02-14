import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:yisty_app/models/alert_tpye.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({Key key, this.message, this.onClose,
    @required this.alertType}) : super(key: key);

  final String message;
  final Function onClose;
  final AlertType alertType;

  MaterialColor _getColor(AlertType alertType) {
    MaterialColor color = Colors.red;
    if(AlertType.SUCCESS == alertType) {
      color = Colors.green;
    }

    if(AlertType.WARNING == alertType) {
      color = Colors.orange;
    }
    return color;
  }

  Icon _getIcon(AlertType alertType) {
    Icon icon = const Icon(Icons.error_outline);
    if(AlertType.SUCCESS == alertType) {
      icon = const Icon(Icons.check_circle_outline);
    }

    if(AlertType.WARNING == alertType) {
      icon = const Icon(Icons.warning_amber_outlined);
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getColor(alertType),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _getIcon(alertType),
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