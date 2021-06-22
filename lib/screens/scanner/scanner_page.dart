import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
  File _ingredientsPicture;

  void onScanner(String barcode) {
    InheritedProvider.of(context).uiStore.removeAlert();

    setState(() {
      _step = 'results';
      _barcode = barcode;
      _ingredientsPicture = null;
    });
  }

  void onFinish() {
    setState(() {
      _step = 'barcode';
      _barcode = null;
      _ingredientsPicture = null;
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
    ).then((File ingredientsPicture) {
      if (ingredientsPicture == null) {
        setState(() {
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
          _step = 'ingredients';
          _ingredientsPicture = ingredientsPicture;
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
          barcode: _barcode,
          user: user
        );
      case 'ingredients':
        return ScannerIngredientsStep(
          barcode: _barcode,
          onRetry: onIngredientsScan,
          onFinish: onFinish,
          picture: _ingredientsPicture
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
