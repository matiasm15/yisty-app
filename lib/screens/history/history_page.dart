import 'package:flutter/material.dart';

import 'package:yisty_app/models/user_scan.dart';
import 'package:yisty_app/screens/history/widgets/history_list.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/services/user_scan_service.dart';
import 'package:yisty_app/widgets/design/empty_page.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/index.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InheritedProvider provider = InheritedProvider.of(context);
    final UserScanService userScanService = provider.services.userScans;

    return AppScaffold(
      body: FutureBuilder<List<UserScan>>(
        future: userScanService.list(),
        builder: (_ , AsyncSnapshot<List<UserScan>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.error is AppException) {
              return AlertPage(
                message: snapshot.error.toString()
              );
            } else {
              throw snapshot.error;
            }
          }

          if (snapshot.hasData) {
            final List<UserScan> userScans = snapshot.data;

            if (userScans.isEmpty) {
              return const EmptyPage(
                  message: 'No tienes productos en tu historial',
                  icon: Icons.list
              );
            }

            return HistoryList(userScans: userScans);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/scanner'),
        tooltip: 'Increment',
        child: const Icon(Icons.camera_alt)
      ),
        title: const Text('Historial')
    );
  }
}