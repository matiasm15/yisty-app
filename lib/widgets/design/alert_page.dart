import 'package:flutter/material.dart';
import 'package:yisty_app/models/alert_type.dart';
import 'package:yisty_app/widgets/design/alert_box.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({Key key, this.message}) : super(key: key);

  final String message;

  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  bool visible = true;

  void _hide() {
    setState(() {
      visible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return AlertBox(
        message: widget.message,
        onClose: () => _hide(),
        alertType: AlertType.ERROR,
      );
    } else {
      return Container();
    }
  }
}
