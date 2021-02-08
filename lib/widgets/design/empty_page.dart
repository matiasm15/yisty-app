import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key key, this.message, this.icon}) : super(key: key);

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon, size: 100, color: Colors.grey[700]),
                    Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18))
                  ],
                )
            )

    );
  }
}
