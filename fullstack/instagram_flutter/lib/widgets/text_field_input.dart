import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final TextInputType keyboardType;

  const TextFieldInput({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: controller,
      obscureText: isPassword,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: hintText,
        border: inputBorder,
        enabled: true,
        filled: true,
        enabledBorder: inputBorder,
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
