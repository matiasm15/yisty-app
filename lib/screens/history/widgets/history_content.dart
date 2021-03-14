import 'package:flutter/material.dart';

import 'package:yisty_app/models/user_scan.dart';
import 'package:yisty_app/screens/history/widgets/history_list.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/empty_widget.dart';
import 'package:yisty_app/widgets/design/loading_widget.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

class HistoryContent extends StatefulWidget {
  const HistoryContent({Key key}) : super(key: key);

  @override
  _HistoryContentState createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  Future<List<UserScan>> future;

  @override
  void didChangeDependencies() {
    future ??= InheritedProvider.of(context).services.userScans.list();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserScan>>(
        future: future,
        builder: (_ , AsyncSnapshot<List<UserScan>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.error is AppException) {
              return AlertPage(
                  message: snapshot.error.toString()
              );
            }

            throw snapshot.error;
          }

          if (snapshot.hasData) {
            final List<UserScan> userScans = snapshot.data;

            if (userScans.isEmpty) {
              return const EmptyWidget(
                  message: 'No tienes productos en tu historial',
                  icon: Icons.list
              );
            }

            return HistoryList(userScans: userScans);
          }

          return LoadingWidget();
        }
    );
  }
}