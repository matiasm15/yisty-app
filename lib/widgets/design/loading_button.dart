import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({Key key, this.text, this.onPressed}) : super(key: key);

  final void Function(RoundedLoadingButtonController) onPressed;
  final String text;

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  Future<void> _doSomething() async {
    widget.onPressed(_btnController);
  }

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      child: Text(widget.text, style: const TextStyle(color: Colors.white)),
      controller: _btnController,
      onPressed: _doSomething,
      color: Theme.of(context).buttonColor
    );
  }
}
