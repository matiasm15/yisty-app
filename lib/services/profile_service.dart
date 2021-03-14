import 'dart:async';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/profile.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class ProfileService extends BaseService {
  ProfileService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<List<Profile>> getProfiles() async {
    final ApiResponse apiResponse =  await client.get(
        'food_preferences');
    final List<Object> jsonList = apiResponse.json()['data'] as List<Object>;

    return jsonList.map((Object json) =>
        Profile.fromJson(json as Map<String, dynamic>)).toList();
  }
}