import 'package:flutter/material.dart';
import 'package:yisty_app/models/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key key, this.products, this.onTap}) : super(key: key);

  final List<Product> products;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int i) {
          final Product product = products[i];

          return ListTile(
              leading: (product.image != null) ? Text(product.image) : null,
              title: Text(product.name),
              subtitle: Text(product.barcode),
              trailing: Text(product.id.toString()),
              onTap: () => onTap(product)
          );
        }
    );
  }
}