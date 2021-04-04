import 'dart:async';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/user_scan.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class UserScanService extends BaseService {
  UserScanService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<UserScan> create(Map<String, String> body) async {
    final ApiResponse apiResponse = await client.post(
        'user_scans',
        body: body
    );
    final Map<String, dynamic> json = apiResponse.json() as Map<String, dynamic>;

    return UserScan.fromJson(json);
  }

  Future<List<UserScan>> list() async {
    final ApiResponse apiResponse = await client.get('user_scans');
    final List<Object> jsonList = apiResponse.json()['data'] as List<Object>;

    final List<UserScan> userScans = jsonList.map<UserScan>((Object json) {
      return UserScan.fromJson(json as Map<String, dynamic>);
    }).toList();

    userScans.sort((UserScan a, UserScan b) => b.date.compareTo(a.date));

    return userScans;
  }
}
