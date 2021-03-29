import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/widgets/products/product_barcode.dart';
import 'package:yisty_app/widgets/products/product_matching.dart';
import 'package:yisty_app/widgets/design/subtitle.dart';

class ProductInformation extends StatelessWidget {
  const ProductInformation({Key key, this.product}) : super(key: key);

  final Product product;

  Widget buildMatching(double width) {
    return Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Container(
                child: const Text(
                    '¿Es apto?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                ),
                margin: const EdgeInsets.only(bottom: 10)
            ),
            Center(child: ProductMatching(
                product: product
            ))
          ],
        )
    );
  }

  Widget buildImage() {
    return Row(
        children: <Widget>[
          Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Image.network(
                    product.image,
                    fit: BoxFit.fitHeight
                ),
                height: 300,
              )
          )
        ]
    );
  }

  Widget buildTitle(BuildContext context) {
    return Container(
      child: Subtitle(text: product.name, type: SubtitleType.h1),
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 7),
    );
  }

  Widget buildBarcode(BuildContext context, double width) {
    return Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Container(
                child: const Text(
                    'Código de barras',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                ),
                margin: const EdgeInsets.only(bottom: 10)
            ),
            ProductBarcode(product: product),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.5 - 1;

    return Column(
      children: <Widget>[
        buildImage(),
        buildTitle(context),
        Container(
            child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildMatching(width),
                    const VerticalDivider(color: Colors.black, width: 2),
                    buildBarcode(context, width)
                  ],
                )
            ),
            margin: const EdgeInsets.only(bottom: 10)
        )
      ]
    );
  }
}