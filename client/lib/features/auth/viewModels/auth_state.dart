class AuthState {
  final bool isLoading;
  final String? errorMessage;

  AuthState({required this.isLoading, this.errorMessage});

  factory AuthState.initial() {
    return AuthState(isLoading: false);
  }

  AuthState copyWith({bool? isLoading, String? errorMessage}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
