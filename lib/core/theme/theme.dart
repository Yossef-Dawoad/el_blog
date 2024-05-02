import 'package:clean_blog/core/theme/color_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _makeBorder([color = Pallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 4.0),
        borderRadius: BorderRadius.circular(10.0),
      );

  static ThemeData darkThemeData = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Pallete.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Pallete.backgroundColor,
      ),
      textTheme: const TextTheme().copyWith(
        titleLarge: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
        ),
        labelMedium: const TextStyle(
          fontSize: 22,
        ),
        labelSmall: const TextStyle(
          fontSize: 18,
        ),
      ),
      chipTheme: const ChipThemeData(
        color: MaterialStatePropertyAll<Color>(Pallete.backgroundColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: _makeBorder(),
        contentPadding: const EdgeInsets.all(25),
        enabledBorder: _makeBorder(),
        focusedBorder: _makeBorder(Pallete.gradient2),
        errorBorder: _makeBorder(Pallete.errorColor),
      ));
}
