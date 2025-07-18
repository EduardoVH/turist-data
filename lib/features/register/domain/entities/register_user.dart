import 'package:equatable/equatable.dart';

class RegisterUser extends Equatable {
  final String nombre;
  final String correo;
  final String password;

  const RegisterUser({
    required this.nombre,
    required this.correo,
    required this.password,
  });

  @override
  List<Object?> get props => [nombre, correo, password];
}
