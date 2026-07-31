class User {
  final String id;
  final String? email;
  final String? username;
  final String? name;
  final String phone;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final DateTime? createdAt;

  const User({
    required this.id,
    this.email,
    this.username,
    this.name,
    required this.phone,
    this.firstName,
    this.lastName,
    this.avatar,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatar: json['avatar'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }
}

class AuthResponse {
  final String token;
  final String? refreshToken;
  final String? tokenType;
  final User user;

  const AuthResponse({
    required this.token,
    this.refreshToken,
    this.tokenType,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      tokenType: json['token_type'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': email,
        'password': password,
      };
}
