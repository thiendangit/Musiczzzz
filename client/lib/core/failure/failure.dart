class AppFailure {
  final String message;
  AppFailure([this.message = 'Sorry, an unexpected error occured!']);

  @override
  String toString() {
    return 'AppFailure(message: $message)';
  }
}
