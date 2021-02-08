import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/profile.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/products/product_preview.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key key, this.products, this.onTap}) : super(key: key);

  final List<Product> products;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final Profile profile = InheritedProvider.of(context).uiStore.user.profile;

    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int i) {
          return ProductPreview(
            profile: profile,
            product: products[i],
            onTap: onTap,
          );
        }
    );
  }
}