import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:client/features/auth/views/pages/forgot_password_page.dart';

void main() {
  testWidgets('Forgot Password Page - Email Validation',
      (WidgetTester tester) async {
    // Build the Forgot Password page
    await tester.pumpWidget(const MaterialApp(home: ForgotPasswordPage()));

    // Find the email text field and the send button
    final emailField = find.byType(TextFormField);
    final sendButton = find.byType(ElevatedButton);

    // Enter an invalid email
    await tester.enterText(emailField, 'invalid-email');
    await tester.tap(sendButton);
    await tester.pump(); // Rebuild the widget after the state has changed

    // Check for the validation error message
    expect(find.text('Please enter a valid email'), findsOneWidget);

    // Enter a valid email
    await tester.enterText(emailField, 'test@example.com');
    await tester.tap(sendButton);
    await tester.pump(); // Rebuild the widget after the state has changed

    // Check that the reset link message is printed (you can also check for other UI changes)
    expect(find.text('Send Reset Link'), findsOneWidget);
  });
}
