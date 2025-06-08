import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_state.dart';
part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AuthState build() {
    return AuthState.initial();
  }
}
