import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterRequested extends RegisterEvent {
  final String nombre;
  final String correo;
  final String password;

  const RegisterRequested({
    required this.nombre,
    required this.correo,
    required this.password,
  });

  @override
  List<Object?> get props => [nombre, correo, password];
}
