import 'dart:convert';

import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/models/auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteReponsitories {
  var baseUrl = '127.0.0.1:8000/auth';

  Future<Either<AppFailure, User>> signUp(UserCreate user) async {
    try {
      var response =
          await http.post(Uri.parse('http://127.0.0.1:8000/auth/signup/'),
              body: jsonEncode({
                'username': user.username,
                'email': user.email,
                'password': user.password,
              }),
              headers: {'content-type': 'application/json'});

      var responseDecode = (jsonDecode(response.body) as Map<String, dynamic>);

      if (response.statusCode == 200) {
        return Right(User.fromJson(response.body));
      } else {
        return Left(AppFailure(responseDecode['detail']));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<void> signIn() async {}
}
