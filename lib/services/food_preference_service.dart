import 'dart:async';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/food_preference.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class FoodPreferenceService extends BaseService {
  FoodPreferenceService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<List<FoodPreference>> getFoodPreferences() async {
    final ApiResponse apiResponse =  await client.get(
        'food_preferences');
    final List<Object> jsonList = apiResponse.json()['data'] as List<Object>;

    return jsonList.map((Object json) =>
        FoodPreference.fromJson(json as Map<String, dynamic>)).toList();
  }
}