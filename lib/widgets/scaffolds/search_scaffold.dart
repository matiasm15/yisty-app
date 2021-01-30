import 'package:flutter/material.dart';
import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/screens/search/product_search.dart';
import 'package:yisty_app/widgets/scaffolds/basic_scaffold.dart';
import 'package:yisty_app/widgets/scaffolds/menu_drawer.dart';

@immutable
class SearchScaffold extends StatelessWidget {
  const SearchScaffold({Key key, this.body, this.floatingActionButton}) : super(key: key);

  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(onPressed: () => showSearch<Product>(context: context, delegate: ProductSearch()), icon: const Icon(Icons.search))
          ],
            title: Row(
          children: <Widget>[
            Padding(
                child: Image.asset('assets/logo.png', width: 30, height: 30),
                padding: const EdgeInsets.only(right: 10)),
            const Text('Yisty'),
          ],
        )),
        body: body,
        floatingActionButton: floatingActionButton,
        drawer: MenuDrawer());
  }
}
