import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:yisty_app/models/ingredient.dart';
import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/scanner/widgets/scanner_barcode_step.dart';
import 'package:yisty_app/screens/scanner/widgets/scanner_ingredients_step.dart';
import 'package:yisty_app/screens/scanner/widgets/scanner_results_step.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

@immutable
class ScannerPage extends StatefulWidget {
  const ScannerPage({Key key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String _step = 'barcode';
  String _barcode;
  Future<Product> _productFuture;
  Future<List<Ingredient>> _ingredientsFuture;

  Future<Product> getProductBy(String barcode) {
    return InheritedProvider.of(context).services.products.list(<String, String>{
      'barcode': barcode
    }).then((List<Product> products) {
      return products.isEmpty ? null : products.first;
    });
  }

  Future<List<Ingredient>> getIngredientsBy(String picture) {
    return InheritedProvider.of(context).services.ingredients.scan(picture);
  }

  void onScanner(String barcode) {
    InheritedProvider.of(context).uiStore.removeAlert();

    setState(() {
      _step = 'results';
      _barcode = barcode;
      _productFuture = getProductBy(barcode);
      _ingredientsFuture = null;
    });
  }

  void onFinish() {
    setState(() {
      _step = 'barcode';
      _barcode = null;
      _productFuture = null;
      _ingredientsFuture = null;
    });
  }

  Future<void> onIngredientsScan() async {
    InheritedProvider.of(context).uiStore.removeAlert();

    final PickedFile picture = await ImagePicker().getImage(source: ImageSource.camera);

    if (picture != null) {
      setState(() {
        _step = 'ingredients';
        _productFuture = null;
        _ingredientsFuture = getIngredientsBy(picture.path);
      });
    }
  }

  Widget _buildBody(User user) {
    switch (_step) {
      case 'barcode':
        return ScannerBarcodeStep(
          onScanner: onScanner
        );
      case 'results':
        return ScannerResultsStep(
          onFinish: onFinish,
          onIngredientsScan: onIngredientsScan,
          productFuture: _productFuture,
          user: user
        );
      case 'ingredients':
        return ScannerIngredientsStep(
          barcode: _barcode,
          onRetry: onIngredientsScan,
          onFinish: onFinish,
          ingredientsFuture: _ingredientsFuture
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      builder: (User user) => _buildBody(user),
      title: const Text('Escanear producto')
    );
  }
}
