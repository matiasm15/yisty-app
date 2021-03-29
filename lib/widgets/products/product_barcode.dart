import 'package:flutter/material.dart';

import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:yisty_app/models/product.dart';

class ProductBarcode extends StatelessWidget {
  const ProductBarcode({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final String svg = Barcode.code128().toSvg(product.barcode, width: 25, height: 35);

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SvgPicture.string(svg, width: 25, fit: BoxFit.fitWidth),
            padding: const EdgeInsets.only(right: 10),
            height: 20,
          ),
          Text(product.barcode)
        ]
    );
  }
}