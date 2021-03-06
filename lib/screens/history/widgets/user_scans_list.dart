import 'package:flutter/material.dart';

import 'package:yisty_app/models/profile.dart';
import 'package:yisty_app/models/user_scan.dart';
import 'package:yisty_app/widgets/products/product_preview.dart';

class UserScansList extends StatelessWidget {
  const UserScansList({Key key, this.userScans, this.profile}) : super(key: key);

  final Profile profile;
  final List<UserScan> userScans;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: userScans.length,
        itemBuilder: (BuildContext context, int i) {
          final UserScan userScan = userScans[i];

          return ProductPreview(
            profile: profile,
            date: userScan.date,
            product: userScan.product
          );
        }
    );
  }
}