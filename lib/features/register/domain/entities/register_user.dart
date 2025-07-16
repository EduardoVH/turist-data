import 'package:equatable/equatable.dart';

class RegisterUser extends Equatable {
  final String email;
  final String password;

  const RegisterUser({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
} 