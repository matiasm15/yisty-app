import 'dart:io';

import 'package:flutter/material.dart';

import 'package:yisty_app/models/ingredient.dart';
import 'package:yisty_app/screens/scanner/widgets/ingredients_information.dart';
import 'package:yisty_app/screens/scanner/widgets/ingredients_not_found.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/widgets/design/loading_widget.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

class ScannerIngredientsStep extends StatefulWidget {
  const ScannerIngredientsStep({Key key, this.barcode, this.onFinish, this.onRetry, this.picture}) : super(key: key);

  final void Function() onFinish;
  final void Function() onRetry;
  final File picture;
  final String barcode;

  @override
  _ScannerIngredientsStepState createState() => _ScannerIngredientsStepState();
}

class _ScannerIngredientsStepState extends State<ScannerIngredientsStep> {
  Future<List<Ingredient>> future;

  @override
  void didChangeDependencies() {
    future ??= InheritedProvider.of(context).services.ingredients.scan(widget.picture);

    super.didChangeDependencies();
  }

  Widget _buildError(AsyncSnapshot<List<Ingredient>> snapshot) {
    if (snapshot.error is AppException) {
      return AlertPage(
          message: snapshot.error.toString()
      );
    }

    throw snapshot.error;
  }

  Widget _buildIngredients(AsyncSnapshot<List<Ingredient>> snapshot) {
    final List<Ingredient> ingredients = snapshot.data;

    if (ingredients.isEmpty) {
      return IngredientsNotFound(onRetry: widget.onRetry, onFinish: widget.onFinish);
    } else {
      return IngredientsInformation(barcode: widget.barcode, ingredients: ingredients, onFinish: widget.onFinish);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ingredient>>(
      future: future,
      builder: (_ , AsyncSnapshot<List<Ingredient>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (snapshot.error is AppException) {
              return _buildError(snapshot);
            }

            throw snapshot.error;
          }

          return _buildIngredients(snapshot);
        }

        return const LoadingWidget(
          title: 'Procesando imagen...',
          text: 'El procesamiento puede tardar varios segundos. Por favor espere.'
        );
      }
    );
  }
}
