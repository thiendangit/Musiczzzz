import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Pallete.gradient2, width: 10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Pallete.gradient2, width: 10),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
  );
}