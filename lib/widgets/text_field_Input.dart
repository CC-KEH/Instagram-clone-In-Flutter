import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String label;
  final String hintText;
  final bool ispasswd;
  final TextInputType textInputType;
  final TextEditingController controller;

  const TextFieldInput(
      {super.key, required this.label, required this.hintText,this.ispasswd=false, required this.textInputType, required this.controller,});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: ispasswd,
    );
  }
}
