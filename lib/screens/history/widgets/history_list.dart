import 'package:flutter/material.dart';

import 'package:yisty_app/models/profile.dart';
import 'package:yisty_app/models/user_scan.dart';
import 'package:yisty_app/screens/history/widgets/user_scans_list.dart';
import 'package:yisty_app/util/date_time_utils.dart';
import 'package:yisty_app/util/list_extensions.dart';
import 'package:yisty_app/widgets/design/subtitle.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({Key key, this.userScans}) : super(key: key);

  final List<UserScan> userScans;

  Widget buildListByDate({List<UserScan> scansByDate, String date, Profile profile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Subtitle(text: date, type: SubtitleType.h2),
        UserScansList(userScans: scansByDate, profile: profile)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Profile profile = InheritedProvider.of(context).uiStore.user.profile;

    final Map<String, List<UserScan>> scansBy = userScans.groupBy<String>((UserScan scan) {
      final DateTime time = DateTime(scan.date.year, scan.date.month, scan.date.day);

      return DateTimeUtils.ago(time);
    });

    return ListView.builder(
        shrinkWrap: true,
        itemCount: scansBy.length,
        itemBuilder: (BuildContext context, int i) {
          final String date = scansBy.keys.elementAt(i);
          final List<UserScan> scansByDate = scansBy[date];

          return buildListByDate(
              scansByDate: scansByDate,
              date: date,
              profile: profile
          );
        }
    );
  }
}