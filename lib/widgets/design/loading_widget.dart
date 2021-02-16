import 'package:flutter/material.dart';

import 'package:yisty_app/widgets/inherited_provider.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EdgeInsets padding = InheritedProvider.of(context).uiStore.screenPadding;

    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height - padding.top - padding.bottom - kToolbarHeight,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor)
          )
        )
      )
    );
  }
}