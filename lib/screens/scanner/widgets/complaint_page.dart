import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/models/alert_type.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/user.dart';
import 'package:yisty_app/models/user_complaint.dart';
import 'package:yisty_app/widgets/design/loading_button.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/scaffolds/app_scaffold.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({Key key, this.onFinish, this.product}) : super(key: key);

  final Product product;
  final void Function() onFinish;

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  String _description = '';

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _descriptionChanged(String value) {
    setState(() {
      _description = value;
    });
  }

  String _descriptionValidator(String value) {
    if (value.isEmpty) {
      return 'El mensaje no puede ser vacío';
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
        'active': 'true',
        'date': DateTime.now().toIso8601String(),
        'description': _description,
        'productId': widget.product.id.toString(),
        'userId': uiStore.user.id.toString()
      };

      provider.services.userComplaints.create(body).then((UserComplaint _) {
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
                onChanged: _descriptionChanged,
                validator: _descriptionValidator,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Tu mensaje'
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
              'Gracias por tu ayuda para mejorar a Yisty. Necesitamos que nos'
              ' digas que datos están mal en el producto para que lo podamos solucionar.',
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
      title: const Text('Feedback')
    );
  }
}