import 'package:flutter/material.dart';

import 'package:yisty_app/screens/home/widgets/home_show.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';
import 'package:yisty_app/widgets/scaffolds/menu_drawer.dart';

@immutable
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      builder: (_) => const HomeShow(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/scanner'),
        tooltip: 'Increment',
        child: const Icon(Icons.camera_alt),
      ),
      search: true,
      drawer: MenuDrawer(),
      title: Row(
        children: <Widget>[
          Padding(
              child: Image.asset('assets/logo.png', width: 30, height: 30),
              padding: const EdgeInsets.only(right: 10)
          ),
          const Text('Yisty'),
        ],
      )
    );
  }
}
