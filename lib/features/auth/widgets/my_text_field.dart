import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? errorText;
  final String label;
  final ValueChanged<String>? onChanged;

  const MyTextField({
    super.key,
    required this.textEditingController,
    this.errorText,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
        errorText: errorText,
        labelText: label,
        labelStyle: const TextStyle(fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
