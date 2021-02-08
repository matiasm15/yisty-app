import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/widgets/design/alert_box.dart';
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

    return AlertBox(
        message: uiStore.errorMessage,
        onClose: () => uiStore.removeErrorMessage()
    );
  }

  @override
  Widget build(BuildContext context) {
    final UiStore uiStore = InheritedProvider.of(context).uiStore;
    final EdgeInsets padding = MediaQuery.of(context).padding;

    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: SafeArea(child: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    observerAlert(uiStore),
                    Container(
                      height: MediaQuery.of(context).size.height - padding.top - padding.bottom - kToolbarHeight,
                      child: widget.body
                    )
                  ]
              )
          )
      ),
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
