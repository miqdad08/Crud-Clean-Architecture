import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;

  const MyButtonWidget({Key? key, required this.onPressed, required this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(textButton),
    );
  }
}
