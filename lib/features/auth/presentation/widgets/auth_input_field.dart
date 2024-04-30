import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  const AuthInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(hintText: hintText, labelText: hintText),
      validator: (value) {
        if (value!.isEmpty) return "$hintText cann't be Empty";
        return null;
      },
    );
  }
}
