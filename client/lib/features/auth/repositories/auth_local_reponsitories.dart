import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/features/auth/models/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'auth_local_reponsitories.g.dart';

@riverpod
AuthLocalReponsitories authLocalReponsitories(Ref ref) {
  return AuthLocalReponsitories();
}

class AuthLocalReponsitories {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // Lưu token
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Lấy token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Lưu thông tin user
  Future<void> setUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, user.toJson());
  }

  // Lấy thông tin user
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return User.fromJson(userJson);
    }
    return null;
  }

  // Lưu cả auth (token + user)
  Future<void> setAuth(Auth auth) async {
    await setToken(auth.accessToken);
    await setUser(auth.user);
  }

  // Lấy auth đã lưu
  Future<Auth?> getAuth() async {
    final token = await getToken();
    final user = await getUser();

    if (token != null && user != null) {
      return Auth(
        accessToken: token,
        tokenType: 'bearer',
        user: user,
      );
    }
    return null;
  }

  // Xóa tất cả dữ liệu auth
  Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  // Kiểm tra có token không
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Kiểm tra có user data không
  Future<bool> hasUser() async {
    final user = await getUser();
    return user != null;
  }

  // Kiểm tra đã đăng nhập chưa
  Future<bool> isAuthenticated() async {
    return await hasToken() && await hasUser();
  }
}
