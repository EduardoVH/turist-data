import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';

abstract class AuthRepository {
  /// Retorna Either con token si el login fue exitoso, o un [Failure] si hubo un error.
  Future<Either<Failure, String>> login(String email, String password);
}
