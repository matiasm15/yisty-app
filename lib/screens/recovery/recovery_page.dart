import 'package:flutter/material.dart';
import 'package:yisty_app/screens/recovery/widgets/recovery_form.dart';
import 'package:yisty_app/widgets/scaffolds/basic_scaffold.dart';

@immutable
class RecoveryPage extends StatelessWidget {
  const RecoveryPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      backgroundColor: Colors.yellow,
      body: Column(children: <Widget>[
        Container(
          child: Image.asset(
            'assets/logo.png',
            height: 300,
            width: 300,
          ),
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        ),
        const SizedBox(height: 15.0,),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: RecoveryForm())
      ]),
    );
  }
}