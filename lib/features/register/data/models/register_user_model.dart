import '../../domain/entities/register_user.dart';

class RegisterUserModel extends RegisterUser {
  const RegisterUserModel({required String email, required String password})
      : super(email: email, password: password);

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
