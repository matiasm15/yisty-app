import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/widgets/design/subtitle.dart';

class ProductShops extends StatelessWidget {
  const ProductShops({Key key, this.product}) : super(key: key);

  final Product product;

  Widget buildShopsList(Product product) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Subtitle(
          text: 'Este producto esta disponible en:',
          type: SubtitleType.h2
        ),
        buildShopsList(product)
      ]
    );
  }
}