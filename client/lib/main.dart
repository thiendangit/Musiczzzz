import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/app_theme.dart';
import 'package:client/features/auth/views/pages/login_page.dart';
import 'package:client/features/auth/views/pages/signup_page.dart';
import 'package:client/features/auth/views/pages/forgot_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 3),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music',
      darkTheme: AppTheme.theme,
      themeMode: ThemeMode.light,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: _border(Pallete.borderColor),
          focusedBorder: _border(Pallete.gradient2),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
      home: const LoginPage(),
      routes: {
        '/signup': (context) => const SignupPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/signin': (context) => const LoginPage(),
      },
    );
  }
}
