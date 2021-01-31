import 'dart:async';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class ProductService extends BaseService {
  ProductService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<List<Product>> list({String q}) async {
    // TODO: send filters
    // final ApiResponse apiResponse = await client.get('products?q=$q');
    final ApiResponse apiResponse = await client.get('products');
    final List<Object> jsonList = apiResponse.json()['data'] as List<Object>;

    return jsonList.map((Object json) => Product.fromJson(json as Map<String, dynamic>)).toList();
  }
}
