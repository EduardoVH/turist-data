import 'package:dartz/dartz.dart';

abstract class RegisterRepository {
  Future<Either<Exception, String>> register(
      String nombre,
      String correo,
      String password,
      );
}
