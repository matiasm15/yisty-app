import 'dart:async';
import 'dart:math';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/user_scan.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class UserScanService extends BaseService {
  UserScanService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<List<UserScan>> list() async {
    // TODO: use user_scans
    final ApiResponse apiResponse = await client.get('products');
    final List<Object> jsonList = apiResponse.json()['data'] as List<Object>;
    final DateTime now = DateTime.now();

    final List<UserScan> userScans = jsonList.map((Object json) {
      return UserScan.fromJson(<String, dynamic>{
        'id': Random.secure().nextInt(100),
        'product': Product.fromJson(json as Map<String, dynamic>),
        'date': DateTime(now.year, now.month, now.day - Random.secure().nextInt(4))
      });
    }).toList();

    userScans.sort((UserScan a, UserScan b) => b.date.compareTo(a.date));

    return userScans;
  }
}
