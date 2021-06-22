import 'dart:async';
import 'dart:io';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/ingredient.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class IngredientService extends BaseService {
  IngredientService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<List<Ingredient>> scan(File picture) async {
    final ApiResponse apiResponse = await client.post(
      'scan',
      body: picture.readAsBytesSync()
    );

    final List<Object> jsonList = apiResponse.json() as List<Object>;

    return jsonList.map(
      (Object json) => Ingredient.fromJson(json as Map<String, dynamic>)
    ).toList();
  }
}