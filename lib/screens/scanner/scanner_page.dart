import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:yisty_app/models/ingredient.dart';
import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/screens/scanner/widgets/scanner_barcode_step.dart';
import 'package:yisty_app/screens/scanner/widgets/scanner_ingredients_step.dart';
import 'package:yisty_app/screens/scanner/widgets/scanner_results_step.dart';
import 'package:yisty_app/widgets/design/loading_widget.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

@immutable
class ScannerPage extends StatefulWidget {
  const ScannerPage({Key key}) : super(key: key);

  String get title => 'Escanear producto';

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool _loading = false;
  String _step = 'barcode';
  String _barcode;
  Future<Product> _productFuture;
  Future<List<Ingredient>> _ingredientsFuture;

  Future<Product> getProductBy(String barcode) {
    final InheritedProvider provider = InheritedProvider.of(context);

    return provider.services.products.list(<String, String>{
      'barcode': barcode
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
  }

  Future<List<Ingredient>> getIngredientsBy(File picture) {
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

  Future<File> _cropImage(PickedFile picture) {
    if (picture == null) {
      return null;
    }

    final ThemeData theme = Theme.of(context);

    return ImageCropper.cropImage(
      sourcePath: picture.path,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: widget.title,
        toolbarColor: theme.primaryColor,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    );
  }

  Future<void> onIngredientsScan() async {
    InheritedProvider.of(context).uiStore.removeAlert();

    setState(() {
      _loading = true;
    });

    ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 25
    ).then(
      (PickedFile picture) => _cropImage(picture)
    ).then((File file) {
      if (file == null) {
        setState(() {
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
          _step = 'ingredients';
          _productFuture = null;
          _ingredientsFuture = getIngredientsBy(file);
        });
      }
    });
  }

  Widget _buildBody(User user) {
    if (_loading) {
      return const LoadingWidget();
    }

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
      title: Text(widget.title)
    );
  }
}
