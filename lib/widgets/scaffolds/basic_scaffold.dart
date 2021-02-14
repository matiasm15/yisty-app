import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/alert_tpye.dart';
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

  Observer observerSuccess(UiStore uiStore) {
    return Observer(builder: (_) => showSuccess(uiStore));
  }

  Observer observerWarning(UiStore uiStore) {
    return Observer(builder: (_) => showWarning(uiStore));
  }

  Widget showAlert(UiStore uiStore) {
    if (uiStore.errorMessage == null) {
      return const SizedBox(
        height: 0,
      );
    }

    return AlertBox(
        message: uiStore.errorMessage,
        onClose: () => uiStore.removeErrorMessage(),
        alertType: AlertType.ERROR,
    );
  }

  Widget showSuccess(UiStore uiStore) {
    if(uiStore.successMessage == null) {
      return const SizedBox(
        height: 0,
      );
    }

    return AlertBox(
      message: uiStore.successMessage,
      onClose: () => uiStore.removeSuccessMessage(),
      alertType: AlertType.SUCCESS
    );
  }

  Widget showWarning(UiStore uiStore) {
    if(uiStore.warningMessage == null) {
      return const SizedBox(
        height: 0,
      );
    }

    return AlertBox(
        message: uiStore.warningMessage,
        onClose: () => uiStore.removeWarningMessage(),
        alertType: AlertType.WARNING
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
                    observerSuccess(uiStore),
                    observerWarning(uiStore),
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
