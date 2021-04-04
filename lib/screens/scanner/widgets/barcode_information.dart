import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/screens/scanner/widgets/complaint_page.dart';
import 'package:yisty_app/widgets/products/product_information.dart';

class BarcodeInformation extends StatelessWidget {
  const BarcodeInformation({Key key, this.onFinish, this.product}) : super(key: key);

  final Product product;
  final void Function() onFinish;

  void onComplaint(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ComplaintPage(
          onFinish: onFinish,
          product: product
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            child: ProductInformation(
                product: product
            ),
            padding: const EdgeInsets.only(bottom: 50),
          ),
          ElevatedButton(
            child: const Text('Escanear otro producto'),
            onPressed: onFinish,
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.warning),
                      Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text('¿Crees que hay un error en esta información?')
                      )
                    ]
                ),
                onPressed: () => onComplaint(context),
              )
          )
        ],
    );
  }
}
