import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/alert_type.dart';
import 'package:yisty_app/models/pending_product.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/widgets/design/loading_button.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

class PendingProductPage extends StatefulWidget {
  const PendingProductPage({Key key, this.barcode, this.onFinish}) : super(key: key);

  final String barcode;
  final void Function() onFinish;

  @override
  _PendingProductPageState createState() => _PendingProductPageState();
}

class _PendingProductPageState extends State<PendingProductPage> {
  String _name = '';
  String _manufacturer = '';

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _nameChanged(String value) {
    setState(() {
      _name = value;
    });
  }

  String _nameValidator(String value) {
    if (value.isEmpty) {
      return 'El nombre no puede ser vacío';
    }

    return null;
  }

  void _manufacturerChanged(String value) {
    setState(() {
      _manufacturer = value;
    });
  }

  String _manufacturerValidator(String value) {
    if (value.isEmpty) {
      return 'El fabricante no puede ser vacío';
    }

    return null;
  }

  void _formSubmitted(RoundedLoadingButtonController controller) {
    FocusScope.of(context).unfocus();

    final InheritedProvider provider = InheritedProvider.of(context);
    final UiStore uiStore = provider.uiStore;
    uiStore.removeAlert();

    // Validate returns true if the form is valid, otherwise false.
    if (_formKey.currentState.validate()) {
      final Map<String, String> body = <String, String> {
        'barcode': widget.barcode,
        'manufacturer': _manufacturer,
        'name': _name,
        'image': 'image'
      };

      provider.services.pendingProducts.create(body).then((PendingProduct _) {
        uiStore.setAlert(
            message: 'Tu mensaje ha sido enviado correctamente y será revisado por nuestros moderadores.',
            type: AlertType.SUCCESS
        );
        Navigator.pop(context);
        widget.onFinish();
      }).catchError(
              (Object error) => uiStore.setAlert(
              message: error.toString(),
              type: AlertType.ERROR
          )
      ).whenComplete(() => controller.reset());
    } else {
      controller.reset();
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Focus(
                    child: TextFormField(
                      onChanged: _nameChanged,
                      validator: _nameValidator,
                      decoration: const InputDecoration(
                          hintText: 'Nombre del producto'
                      ),
                    )
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Focus(
                    child: TextFormField(
                      onChanged: _manufacturerChanged,
                      validator: _manufacturerValidator,
                      decoration: const InputDecoration(
                          hintText: 'Fabricante'
                      ),
                    )
                )
            ),
            Container(
                width: double.infinity,
                height: 40,
                child: LoadingButton(
                  text: 'Enviar',
                  onPressed: _formSubmitted,
                )
            ),
          ]
      ),
    );
  }

  Widget _buildBody(User _user) {
    return Center(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: MediaQuery.of(context).size.width * 0.95,
            child: Column(
                children: <Widget>[
                  const Text(
                    'Gracias por tu ayuda para mejorar a Yisty. Necesitamos que nos indiques algunos datos del producto.',
                    style: TextStyle(fontSize: 16),
                  ),
                  _buildForm()
                ]
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        builder: _buildBody,
        title: const Text('Agregar producto')
    );
  }
}