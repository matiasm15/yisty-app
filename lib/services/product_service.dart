import 'dart:async';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

class ProductService {
  ProductService({this.client});

  RestClient client;

  Future<List<Product>> list({String q}) async {
    final List<Map<String, dynamic>> response = (await client.get(
        'products?q=$q'
    )).json() as List<Map<String, dynamic>>;

    return response.map((Map<String, dynamic> json) => Product.fromJson(json)).toList();
  }
}
