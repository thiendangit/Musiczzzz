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
      title: 'Music App',
      theme: AppTheme.theme,
      home: const SignupPage(),
    );
  }
}

