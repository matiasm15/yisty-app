import 'dart:async';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/pending_product.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class PendingProductService extends BaseService {
  PendingProductService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<PendingProduct> create(Map<String, String> body) async {
    final ApiResponse apiResponse = await client.post(
        'pending_products',
        body: body
    );
    final Map<String, dynamic> json = apiResponse.json() as Map<String, dynamic>;

    return PendingProduct.fromJson(json);
  }
}
