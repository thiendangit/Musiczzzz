import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/app_theme.dart';
import 'package:client/features/auth/views/pages/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music',
      darkTheme: AppTheme.theme,
      themeMode: ThemeMode.light,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Pallete.borderColor, width: 3),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Pallete.borderColor, width: 3),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
      ),
      home: const SignupPage(),
    );
  }
}

