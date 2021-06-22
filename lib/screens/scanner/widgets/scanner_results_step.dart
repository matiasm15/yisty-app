import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/scanner/widgets/barcode_information.dart';
import 'package:yisty_app/screens/scanner/widgets/barcode_not_found.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/widgets/design/loading_widget.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

class ScannerResultsStep extends StatefulWidget {
  const ScannerResultsStep({Key key, this.barcode, this.onFinish, this.onIngredientsScan, this.user}) : super(key: key);

  final void Function() onFinish;
  final void Function() onIngredientsScan;
  final String barcode;
  final User user;

  @override
  _ScannerResultsStepState createState() => _ScannerResultsStepState();
}

class _ScannerResultsStepState extends State<ScannerResultsStep> {
  Future<Product> future;

  @override
  void didChangeDependencies() {
    final InheritedProvider provider = InheritedProvider.of(context);

    future ??= provider.services.products.list(<String, String>{
      'barcode': widget.barcode
    }).then((List<Product> products) {
      if (products.isEmpty) {
        return null;
      }

      final Product product = products.first;

      provider.services.userScans.create(
        <String, String>{
          'date': DateTime.now().toIso8601String(),
          'result': product.foodPreference.toString(),
          'productId': product.id.toString(),
          'userId': provider.uiStore.user.id.toString()
        }
      );

      return product;
    });

    super.didChangeDependencies();
  }

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
      return BarcodeNotFound(
        barcode: widget.barcode,
        onFinish: widget.onFinish,
        onIngredientsScan: widget.onIngredientsScan
      );
    } else {
      return BarcodeInformation(
        product: product,
        onFinish: widget.onFinish
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: future,
      builder: (_ , AsyncSnapshot<Product> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (snapshot.error is AppException) {
              return _buildError(snapshot);
            }

            throw snapshot.error;
          }

          return _buildProduct(snapshot);
        }

        return const LoadingWidget();
      }
    );
  }
}