import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/widgets/design/matching.dart';

class ProductMatching extends StatelessWidget {
  const ProductMatching({Key key, this.product, this.icon = true, this.size = 24}) : super(key: key);

  final Product product;
  final bool icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    MatchingType type;

    if (product.isPermitted) {
      type = MatchingType.good;
    } else if (product.isDenied) {
      type = MatchingType.bad;
    } else {
      type = MatchingType.unknown;
    }

    return Matching(type: type, icon: icon, size: size);
  }
}