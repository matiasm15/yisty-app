import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/products/widgets/affiliate_shops_list.dart';
import 'package:yisty_app/widgets/products/product_information.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        builder: (User user) {
          return Column(
            children: <Widget>[
              ProductInformation(product: product),
              AffiliateShopsList(affiliateShops: product.affiliateShops)
            ]
          );
        },
        title: Text(product.name)
    );
  }
}