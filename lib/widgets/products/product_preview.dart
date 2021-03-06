import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/profile.dart';
import 'package:yisty_app/screens/products/product_page.dart';

class ProductPreview extends StatelessWidget {
  const ProductPreview({Key key, @required this.product, @required this.profile, this.date}) : super(key: key);

  final Profile profile;
  final Product product;
  final DateTime date;

  Widget buildMatching() {
    if (profile.isPermitted(product)) {
      return buildMatchingText('APTO', Colors.green);
    } else if (Profile().isDenied(product)) {
      return buildMatchingText('NO APTO', Colors.red);
    } else {
      return buildMatchingText('DESCONOCIDO', Colors.grey);
    }
  }

  Widget buildMatchingText(String message, Color color) {
    return Text(
      message,
      style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Widget buildShops() {
    final int shopsQuantity = product.shopsQuantity();

    if (shopsQuantity == 0) {
      return Container();
    }

    return Row(
      children: <Widget>[
        const Icon(Icons.local_offer, size: 18, color: Colors.blueAccent),
        Text(' $shopsQuantity', style: const TextStyle(fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold))
      ]
    );
  }

  Widget buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                product.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              margin: const EdgeInsets.only(bottom: 2)
            ),
            Text(
              product.barcode,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal)
            )
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            buildMatching(),
            buildShops()
          ],
        )
      ],
    );
  }

  Widget buildImage() {
    return Image.network(
      product.image,
      fit: BoxFit.fitWidth,
      height: 100,
      width: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildImage(),
                Expanded(child: Container(child: buildInfo(), padding: const EdgeInsets.symmetric(horizontal: 10), height: 100,))
              ],
            )
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<ProductPage>(
                builder: (BuildContext context) => ProductPage(product: product)
              )
            );
          }
        )
    );
  }
}