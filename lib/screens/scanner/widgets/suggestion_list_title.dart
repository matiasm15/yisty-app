import 'package:flutter/material.dart';

class SuggestionListTile extends StatelessWidget {
  const SuggestionListTile({Key key, this.title, this.subtitle}) : super(key: key);

  final Widget title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 10.0,
          width: 10.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
        ),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
      minLeadingWidth: 0,
      title: title,
      subtitle: subtitle,
    );
  }
}