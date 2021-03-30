import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:yisty_app/screens/scanner/widgets/scanner_button.dart';
import 'package:yisty_app/widgets/design/subtitle.dart';

class ScannerBarcodeStep extends StatelessWidget {
  const ScannerBarcodeStep({Key key, this.onScanner}) : super(key: key);

  final void Function(String) onScanner;

  Future<void> _openCamera(BuildContext context) async {
    final Color color = Theme.of(context).primaryColor;

    final String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#${color.value.toRadixString(16)}',
      'Cancelar',
      true,
      ScanMode.BARCODE
    );

    // -1 es el valor que devuelve la libreria cuando cancelan el escaneo.
    if (barcode.isNotEmpty && barcode != '-1') {
      onScanner(barcode);
    }
  }

  Widget _buildDescription() {
    return Container(
      child: const Text(
        'Escanea el código de barras de un producto y averigua si es apto para vos.',
        textAlign: TextAlign.center
      ),
      padding: const EdgeInsets.only(top: 40),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      'assets/barcode_scanner.png'
    );
  }

  Widget _buildButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ScannerButton(
            icon: Icons.camera_alt,
            onPressed: _openCamera,
            text: 'Camara'
          ),
          // ScannerButton(
          //   icon: Icons.filter,
          //   onPressed: (_) {},
          //   text: 'Galeria'
          // )
        ],
      ),
      padding: const EdgeInsets.only(top: 15)
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          child: Column(
            children: <Widget>[
              Subtitle(
                text: '¿Cómo querés escanear el producto?',
                type: SubtitleType.h2
              ),
              _buildButtons()
            ]
          ),
          padding: const EdgeInsets.only(top: 10, bottom: 20)
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildDescription(),
              _buildImage(),
              _buildCard(context)
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.8,
        )
    );
  }
}