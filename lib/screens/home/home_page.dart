import 'package:flutter/material.dart';
import 'package:yisty_app/widgets/scaffolds/search_scaffold.dart';

@immutable
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchScaffold(
      body: const Text('Listado de noticias'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/scanner'),
        tooltip: 'Increment',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
