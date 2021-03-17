import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/food_preference.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/products/product_preview.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key key, this.products, this.onTap}) : super(key: key);

  final List<Product> products;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final FoodPreference foodPreference = InheritedProvider.of(context).uiStore.user.foodPreference;

    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int i) {
          return ProductPreview(
            foodPreference: foodPreference,
            product: products[i]
          );
        }
    );
  }
}