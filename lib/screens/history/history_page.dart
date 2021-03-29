import 'package:flutter/material.dart';

import 'package:yisty_app/screens/history/widgets/history_content.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      builder: (_) => const HistoryContent(),
      title: const Text('Historial')
    );
  }
}