import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/food_preference.dart';
import 'package:yisty_app/screens/products/product_page.dart';
import 'package:yisty_app/widgets/products/product_matching.dart';

class ProductPreview extends StatelessWidget {
  const ProductPreview({Key key, @required this.product, @required this.foodPreference, this.date}) : super(key: key);

  final FoodPreference foodPreference;
  final Product product;
  final DateTime date;

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
            ProductMatching(product: product, icon: false, size: 22),
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