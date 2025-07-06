import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/features/auth/models/auth.dart';
import 'auth_state.dart';
import '../repositories/auth_remote_reponsitories.dart';
import '../repositories/auth_local_reponsitories.dart';
part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRemoteReponsitories _authRemoteRepo;
  late final AuthLocalReponsitories _authLocalRepo;

  @override
  AuthState build() {
    _authRemoteRepo = ref.read(authRemoteReponsitoriesProvider);
    _authLocalRepo = ref.read(authLocalReponsitoriesProvider);

    // Automatically load auth data from local storage on initialization
    _loadSavedAuth();

    return AuthState.initial();
  }

  // Load saved auth data from local storage
  Future<void> _loadSavedAuth() async {
    final savedAuth = await _authLocalRepo.getAuth();
    if (savedAuth != null) {
      state = state.copyWith(
        auth: savedAuth,
        user: savedAuth.user,
      );
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final user = UserCreate(
      email: email,
      password: password,
      username: username,
    );

    final result = await _authRemoteRepo.signUp(user);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (user) => state = state.copyWith(
        isLoading: false,
        errorMessage: null,
        user: user,
      ),
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final user = UserLogin(
      email: email,
      password: password,
    );

    final result = await _authRemoteRepo.signIn(user);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (auth) async {
        // Save auth data to local storage
        await _authLocalRepo.setAuth(auth);

        // Update state
        state = state.copyWith(
          isLoading: false,
          errorMessage: null,
          auth: auth,
          user: auth.user,
        );
      },
    );
  }

  Future<User?> getData() async {
    if (state.auth?.accessToken != null) {
      final result =
          await _authRemoteRepo.getCurrentUser(state.auth?.accessToken ?? '');

      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ),
        (user) async {
          // Update new user data to local storage
          await _authLocalRepo.setUser(user);

          state = state.copyWith(
            isLoading: false,
            errorMessage: null,
            user: user,
          );
        },
      );
    }

    return null;
  }

  // Sign out - clear both local storage and state
  Future<void> signOut() async {
    await _authLocalRepo.clearAuth();
    state = AuthState.initial();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  // Check if there's auth data in local storage
  Future<bool> hasLocalAuth() async {
    return await _authLocalRepo.isAuthenticated();
  }

  // Refresh auth data from local storage if needed
  Future<void> refreshAuthFromLocal() async {
    await _loadSavedAuth();
  }
}
