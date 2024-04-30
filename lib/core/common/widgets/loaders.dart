import 'package:flutter/material.dart';

class FullBodyLoadinIndicator extends StatelessWidget {
  const FullBodyLoadinIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
