import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/products/widgets/product_content.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        builder: (User _) => ProductContent(product: product),
        title: Text(product.name)
    );
  }
}