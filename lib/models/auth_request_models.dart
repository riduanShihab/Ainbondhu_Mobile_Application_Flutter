class LoginRequest {
  final String email;
  final String password;
  LoginRequest({required this.email, required this.password});
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class SignUpRequest {
  final String name;
  final String emailOrPhone;
  final String password;
  SignUpRequest({required this.name, required this.emailOrPhone, required this.password});
  Map<String, dynamic> toJson() => {
    'name': name,
    'email_or_phone': emailOrPhone,
    'password': password
  };
}

class UserModel {
  final String name;
  final String email;
  final String token;

  UserModel({required this.name, required this.email, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}