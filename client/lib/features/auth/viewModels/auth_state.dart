import 'package:client/features/auth/models/auth.dart';

class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final User? user;
  final Auth? auth;

  AuthState({
    required this.isLoading,
    this.errorMessage,
    this.user,
    this.auth,
  });

  factory AuthState.initial() {
    return AuthState(isLoading: false);
  }

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    User? user,
    Auth? auth,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      auth: auth ?? this.auth,
    );
  }

  // Getter to check if user is authenticated
  bool get isAuthenticated => user != null && auth != null;
}
