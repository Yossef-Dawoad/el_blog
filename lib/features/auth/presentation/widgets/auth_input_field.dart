import 'package:flutter/material.dart';

class AuthInputField extends StatefulWidget {
  const AuthInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
  });

  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  bool isPasswordObscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText ?? false & isPasswordObscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.hintText,
        suffixIcon: widget.obscureText != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordObscure = !isPasswordObscure;
                  });
                  print('isPasswordObscure $isPasswordObscure');
                  print('obscureText ${widget.obscureText}');
                },
                icon: isPasswordObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
              )
            : null,
      ),
      validator: (value) {
        if (value!.isEmpty) return "${widget.hintText} cann't be Empty";
        return null;
      },
    );
  }
}
