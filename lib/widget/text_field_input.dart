import 'package:flutter/material.dart';

class WidgetTextFieldInput extends StatelessWidget {
  final String hintText;
  final bool isPass;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String labelText;

  const WidgetTextFieldInput(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.isPass = false,
      required this.controller,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      obscureText: isPass,
      keyboardType: textInputType,
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: const TextStyle(color: Colors.white),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        contentPadding: const EdgeInsets.all(8),
        filled: true,
      ),
    );
  }
}
