import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/models/auth.dart';
import 'package:client/features/auth/repositories/auth_remote_reponsitories.dart';
import 'package:client/features/auth/views/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/views/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    if (formKey.currentState!.validate()) {
      var user = UserCreate(
          username: nameController.text,
          email: emailController.text,
          password: passwordController.text);

      // Call the signup API
      var response = await AuthRemoteReponsitories().signUp(user);

      // Check the response
      response.fold(
        (failure) {
          // Handle signup failure (show error message)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.message), // Access the message property
              backgroundColor: Colors.red,
            ),
          );
        },
        (user) {
          // Assuming response is a Right type on success
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Signup Successful'),
                content: const Text(
                    'You have successfully signed up! Please log in.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pop(
                          context); // Go back to the previous page (LoginPage)
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    'Sign Up.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  CustomField(
                    hintText: 'Name',
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomField(
                    hintText: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomField(
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(onPressed: signUpUser),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context,
                          '/signin'); // Navigate to forgot password page
                    },
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(color: Pallete.gradient2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
