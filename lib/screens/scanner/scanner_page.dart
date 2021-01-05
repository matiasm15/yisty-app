import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@immutable
class ScannerPage extends StatefulWidget {
  const ScannerPage({Key key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _openGallery(BuildContext context) async {
    final PickedFile picture =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _openCamera(BuildContext context) async {
    final PickedFile picture =
        await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Seleccionar origen'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text('Galería'),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text('Tomar foto'),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _checkImageView() {
    if (_imageFile == null) {
      return const Text('Ninguna imagen seleccionada');
    } else {
      return Image.file(File(_imageFile.path), width: 400, height: 400);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _checkImageView(),
            RaisedButton(
              onPressed: () {
                _showChoiceDialog(context);
              },
              child: const Text('Seleccionar Imagen'),
            )
          ],
        ),
      ),
    );
  }
}
