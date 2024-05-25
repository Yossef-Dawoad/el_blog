import 'package:flutter/material.dart';

enum Languages {
  english(
    Locale('en', 'US'),
    'assets/images/english.png',
    "English",
  ),
  arabic(
    Locale('ar', 'AR'),
    'assets/images/arabic.png',
    "Arabic",
  );

  const Languages(this.locale, this.imagePath, this.name);
  final Locale locale;
  final String imagePath;
  final String name;
}
