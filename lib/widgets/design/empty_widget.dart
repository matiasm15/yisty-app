import 'package:flutter/material.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key key, this.message, this.icon}) : super(key: key);

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = InheritedProvider.of(context).uiStore.screenPadding;

    return Center(
            child: Container(
                height: MediaQuery.of(context).size.height - padding.top - padding.bottom - kToolbarHeight,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon, size: 100, color: Colors.grey[700]),
                    Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18))
                  ],
                )
            )

    );
  }
}
