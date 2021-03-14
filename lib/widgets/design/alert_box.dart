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
    MaterialColor color;
    switch (alertType) {
      case AlertType.ERROR: {
        color = Colors.red;
      }
      break;
      case AlertType.SUCCESS :
        {
          color = Colors.green;
        }
        break;
      case AlertType.WARNING :
        {
          color = Colors.orange;
        }
        break;
    }
    return color;
  }

  Icon _getIcon(AlertType alertType) {
    Icon icon;
    switch (alertType) {
      case AlertType.ERROR: {
        icon = const Icon(Icons.error_outline);
      }
      break;
      case AlertType.SUCCESS :
        {
          icon = const Icon(Icons.check_circle_outline);
        }
        break;
      case AlertType.WARNING :
        {
          icon = const Icon(Icons.warning_amber_outlined);
        }
        break;
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