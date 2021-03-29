import 'dart:async';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/ingredient.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class IngredientService extends BaseService {
  IngredientService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<List<Ingredient>> scan(String picture) async {
    // final ApiResponse apiResponse =  await client.post('instructions');
    // final List<Object> jsonList = apiResponse.json()['data'] as List<Object>;

    // TODO: remove
    final List<Object> jsonList = <Object>[
      <String, dynamic>{
        'id': 1,
        'name': 'Azucar'
      },
      <String, dynamic>{
        'id': 2,
        'name': 'Grasas animales'
      },
      <String, dynamic>{
        'id': 3,
        'name': 'Colorante'
      }
    ];

    return jsonList.map((Object json) =>
        Ingredient.fromJson(json as Map<String, dynamic>)).toList();
  }
}