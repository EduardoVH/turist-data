import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, String>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
