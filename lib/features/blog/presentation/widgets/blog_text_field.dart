import 'package:flutter/material.dart';

class BlogTextField extends StatelessWidget {
  const BlogTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      maxLines: null,
      validator: (value) =>
          (value == null || value.isEmpty) ? '$hintText is Required' : null,
    );
  }
}
