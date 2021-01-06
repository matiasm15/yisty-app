import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

@immutable
class BasicScaffold extends StatefulWidget {
  const BasicScaffold({Key key, this.appBar, this.backgroundColor, this.body, this.drawer, this.floatingActionButton})
      : super(key: key);

  final PreferredSizeWidget appBar;
  final MaterialColor backgroundColor;
  final Widget body;
  final Widget drawer;
  final Widget floatingActionButton;

  @override
  _BasicScaffoldState createState() => _BasicScaffoldState();
}

class _BasicScaffoldState extends State<BasicScaffold> {
  Observer observerAlert(UiStore uiStore) {
    return Observer(builder: (_) => showAlert(uiStore));
  }

  Widget showAlert(UiStore uiStore) {
    if (uiStore.errorMessage == null) {
      return const SizedBox(
        height: 0,
      );
    }

    return Container(
      color: Theme.of(context).errorColor,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.error_outline),
          ),
          Expanded(
            child: AutoSizeText(
              uiStore.errorMessage,
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => uiStore.removeErrorMessage(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UiStore uiStore = InheritedProvider.of(context).uiStore;

    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: SingleChildScrollView(
          child: SafeArea(child: Column(children: <Widget>[observerAlert(uiStore), widget.body]))),
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
