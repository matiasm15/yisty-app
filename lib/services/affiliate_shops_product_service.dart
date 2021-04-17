import 'dart:async';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/affiliate_shop.dart';
import 'package:yisty_app/services/base_service.dart';
import 'package:yisty_app/services/rest_client/api_response.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class AffiliateShopsProductService extends BaseService {
  AffiliateShopsProductService({RestClient client, UiStore uiStore}) : super(client: client, uiStore: uiStore);

  Future<List<AffiliateShop>> list(Map<String, String> filters) async {
    final ApiResponse apiResponse = await client.get(serializeFilters('affiliate_shops_products', filters));
    final List<Object> jsonList = apiResponse.json()['data'] as List<Object>;

    return jsonList.map((Object json) => AffiliateShop.fromJson(json as Map<String, dynamic>)).toList();
  }
}
