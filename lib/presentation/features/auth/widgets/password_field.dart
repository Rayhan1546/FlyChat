import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? errorText;
  final String label;
  final ValueChanged<String> onChanged;

  PasswordField({
    super.key,
    required this.textEditingController,
    this.errorText,
    required this.label,
    required this.onChanged,
  });

  ValueNotifier<bool> hidePassword = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: hidePassword,
      builder: (context, value, _) => TextFormField(
        controller: textEditingController,
        onChanged: onChanged,
        obscureText: value,
        decoration: InputDecoration(
          errorText: errorText,
          labelText: label,
          labelStyle: const TextStyle(fontSize: 20),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            icon: value
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
            onPressed: () => hidePassword.value = !hidePassword.value,
          ),
        ),
      ),
    );
  }
}
