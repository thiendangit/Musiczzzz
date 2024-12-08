// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserCreate {
  String username;
  String email;
  String password;

  UserCreate(
      {required this.username, required this.email, required this.password});
}

class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});
}

class User {
  String? id;
  String? username;
  String? email;

  User({
    this.id,
    this.username,
    this.email,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, username: $username, email: $email)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.username == username && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ email.hashCode;
}

class Auth {
  String accessToken;
  String tokenType;
  User user;

  Auth({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  Auth copyWith({
    String? accessToken,
    String? tokenType,
    User? user,
  }) {
    return Auth(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'user': user.toMap(),
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) =>
      Auth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Auth(accessToken: $accessToken, tokenType: $tokenType, user: $user)';

  @override
  bool operator ==(covariant Auth other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.tokenType == tokenType &&
        other.user == user;
  }

  @override
  int get hashCode => accessToken.hashCode ^ tokenType.hashCode ^ user.hashCode;
}
