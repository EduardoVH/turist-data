import 'package:dartz/dartz.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Exception, String>> call(
      String nombre,
      String correo,
      String password,
      ) async {
    return await repository.register(nombre, correo, password);
  }
}
