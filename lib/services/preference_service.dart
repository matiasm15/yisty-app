import 'dart:async';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/preference.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class PreferenceService extends BaseService {
  PreferenceService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<List<Preference>> getPreferences() async {
    final ApiResponse apiResponse =  await client.get(
        'food_preferences');
    final List<Object> jsonList = apiResponse.json()['data'] as List<Object>;

    return jsonList.map((Object json) =>
        Preference.formJson(json as Map<String, dynamic>)).toList();
  }
}