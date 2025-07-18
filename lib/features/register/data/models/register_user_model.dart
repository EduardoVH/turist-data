import '../../domain/entities/register_user.dart';

class RegisterUserModel extends RegisterUser {
  const RegisterUserModel({
    required String nombre,
    required String correo,
    required String password,
  }) : super(nombre: nombre, correo: correo, password: password);

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
      nombre: json['nombre'] as String,
      correo: json['correo'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'correo': correo,
      'password': password,
    };
  }
}
