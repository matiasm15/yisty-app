import 'package:flutter/material.dart';

class SubtitleType {
  static TextStyle get h1 {
    return const TextStyle(
      fontSize: 22,
      color: Colors.green,
      fontWeight: FontWeight.w600
    );
  }

  static TextStyle get h2 {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey[700]
    );
  }

  static TextStyle get h3 {
    return TextStyle(
      color: Colors.grey[700]
    );
  }
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
          style: type ?? SubtitleType.h1,
          textAlign: TextAlign.center
        ),
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 7, top: 20)
    );
  }
}