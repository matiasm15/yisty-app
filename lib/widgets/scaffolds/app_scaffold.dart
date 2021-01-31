import 'package:flutter/material.dart';
import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/screens/search/product_search.dart';
import 'package:yisty_app/widgets/scaffolds/basic_scaffold.dart';

@immutable
class AppScaffold extends StatelessWidget {
  const AppScaffold({Key key, this.body, this.floatingActionButton, this.title, this.drawer, this.search = false}) : super(key: key);

  final Widget body;
  final Widget drawer;
  final Widget floatingActionButton;
  final Widget title;
  final bool search;

  Widget buildSearch(BuildContext context) {
    if (search) {
      return IconButton(
          onPressed: () => showSearch<Product>(
              context: context,
              delegate: ProductSearch()
          ),
          icon: const Icon(Icons.search)
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        appBar: AppBar(
          actions: <Widget>[
            buildSearch(context)
          ],
          title: title
        ),
        body: body,
        floatingActionButton: floatingActionButton,
        drawer: drawer
    );
  }
}
