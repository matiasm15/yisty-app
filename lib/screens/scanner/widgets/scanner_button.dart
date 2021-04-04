import 'package:flutter/material.dart';

class ScannerButton extends StatelessWidget {
  const ScannerButton({Key key, this.onPressed, this.icon, this.text}) : super(key: key);

  final void Function(BuildContext) onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Ink(
          decoration: ShapeDecoration(
            color: Theme.of(context).primaryColor,
            shape: const CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon),
            color: Colors.white,
            onPressed: () => onPressed(context)
          ),
        ),
        Padding(
          child: Text(text),
          padding: const EdgeInsets.only(
            right: 40,
            left: 40,
            top: 10
          )
        ),
      ],
    );
  }
}