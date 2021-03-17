import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/alert_type.dart';
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
  @override
  void didChangeDependencies() {
    // Deberia poder obtener este dato directamente en donde quiero usarlo pero
    // desde dentro de un SafeArea me devuelve zero.
    final EdgeInsets screenPadding = MediaQuery.of(context).padding;

    InheritedProvider.of(context).uiStore.setScreenPadding(screenPadding);

    super.didChangeDependencies();
  }

  Observer observerAlert(UiStore uiStore) {
    return Observer(builder: (_) => showAlert(uiStore));
  }

  Widget showAlert(UiStore uiStore) {
    if (uiStore.message == null) {
      return const SizedBox(
        height: 0,
      );
    }

    return AlertBox(
        message: uiStore.message,
        onClose: () => uiStore.removeMessageAlertType(),
        alertType: uiStore.alertType,
    );
  }

  Widget buildBody() {
    final UiStore uiStore = InheritedProvider.of(context).uiStore;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              observerAlert(uiStore),
              widget.body
            ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: buildBody(),
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
