import 'package:flutter/material.dart';

class SubtitleType {
  static TextStyle h1 = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey[700]
  );

  static TextStyle h2 = TextStyle(
      color: Colors.grey[700]
  );
}

class Subtitle extends StatelessWidget {
  const Subtitle({Key key, this.text, this.type}) : super(key: key);

  final String text;
  final TextStyle type;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
          text,
          style: type ?? SubtitleType.h1
        ),
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 7, top: 20)
    );
  }
}