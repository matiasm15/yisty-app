import 'package:flutter/material.dart';
import 'package:yisty_app/widgets/design/subtitle.dart';

import 'package:yisty_app/widgets/inherited_provider.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key, this.title, this.text}) : super(key: key);

  final String title;
  final String text;

  Widget _buildProgressIndicator(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor)
    );
  }

  Widget _buildTitle() {
    if (title == null) {
      return Container();
    }

    return Subtitle(text: title);
  }

  Widget _buildText() {
    if (text == null) {
      return Container();
    }

    return Text(text, textAlign: TextAlign.center);
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = InheritedProvider.of(context).uiStore.screenPadding;
    final Size mediaSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: mediaSize.width * 0.8,
        height: mediaSize.height - padding.top - padding.bottom - kToolbarHeight,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProgressIndicator(context),
              _buildTitle(),
              _buildText()
            ],
          )
        )
      )
    );
  }
}