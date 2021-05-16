import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/scanner/widgets/barcode_information.dart';
import 'package:yisty_app/screens/scanner/widgets/barcode_not_found.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/widgets/design/loading_widget.dart';

class ScannerResultsStep extends StatelessWidget {
  const ScannerResultsStep({Key key, this.barcode, this.onFinish, this.onIngredientsScan, this.productFuture, this.user}) : super(key: key);

  final Future<Product> productFuture;
  final void Function() onFinish;
  final void Function() onIngredientsScan;
  final String barcode;
  final User user;

  Widget _buildError(AsyncSnapshot<Product> snapshot) {
    if (snapshot.error is AppException) {
      return AlertPage(
          message: snapshot.error.toString()
      );
    }

    throw snapshot.error;
  }

  Widget _buildProduct(AsyncSnapshot<Product> snapshot) {
    final Product product = snapshot.data;

    if (product == null) {
      return BarcodeNotFound(barcode: barcode, onFinish: onFinish, onIngredientsScan: onIngredientsScan);
    } else {
      return BarcodeInformation(product: product, onFinish: onFinish);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: productFuture,
      builder: (_ , AsyncSnapshot<Product> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _buildError(snapshot);
          }

          return _buildProduct(snapshot);
        }

        return const LoadingWidget();
      }
    );
  }
}