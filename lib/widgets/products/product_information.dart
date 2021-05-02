import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/util/date_time_utils.dart';
import 'package:yisty_app/widgets/products/product_barcode.dart';
import 'package:yisty_app/widgets/products/product_matching.dart';
import 'package:yisty_app/widgets/design/subtitle.dart';

class ProductInformation extends StatelessWidget {
  const ProductInformation({Key key, this.product}) : super(key: key);

  final Product product;

  Widget _buildMatching(double width) {
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

  Widget _buildImage() {
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

  Widget _buildTitle(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Subtitle(
            text: product.name,
            type: SubtitleType.h1,
            padding: const EdgeInsets.only(bottom: 4)
          ),
          Text('${product.category} (${product.manufacturer})')
        ]
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 20),
    );
  }

  Widget _buildBarcode(BuildContext context, double width) {
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
            padding: const EdgeInsets.only(bottom: 10)
          ),
          ProductBarcode(product: product),
        ],
      )
    );
  }

  Widget _buildCenterColumn(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.5 - 1;

    return Center(
      child: Column(
        children: [
          _buildImage(),
          _buildTitle(context),
          Container(
              child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildMatching(width),
                      const VerticalDivider(color: Colors.black, width: 2),
                      _buildBarcode(context, width)
                    ],
                  )
              ),
              margin: const EdgeInsets.only(bottom: 10)
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCenterColumn(context),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const Padding(child: Icon(Icons.timelapse), padding: EdgeInsets.only(right: 5)),
              Text('Actualizado ${DateTimeUtils.ago(product.updatedAt).toLowerCase()}')
            ]
          )
        )
      ]
    );
  }
}