import 'package:flutter/material.dart';
import 'package:yisty_app/widgets/scaffolds/basic_scaffold.dart';
import 'package:yisty_app/widgets/scaffolds/menu_drawer.dart';

@immutable
class SearchScaffold extends StatefulWidget {
  const SearchScaffold({Key key, this.body, this.floatingActionButton}) : super(key: key);

  final Widget body;
  final Widget floatingActionButton;

  @override
  _SearchScaffoldState createState() => _SearchScaffoldState();
}

class _SearchScaffoldState extends State<SearchScaffold> {
  bool _isSearching = false;

  void _openSearchBox() {
    setState(() {
      _isSearching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        appBar: AppBar(
            title: Row(
          children: <Widget>[
            Padding(
                child: Image.asset('assets/logo.png', width: 30, height: 30),
                padding: const EdgeInsets.only(right: 10)),
            const Text('Yisty'),
          ],
        )),
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
        drawer: MenuDrawer());
  }
}
