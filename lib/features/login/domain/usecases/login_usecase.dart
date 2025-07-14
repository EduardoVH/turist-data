import 'package:dartz/dartz.dart';
import 'package:untitled/features/login/domain/repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';
import 'package:untitled/features/login/domain/repositories/auth_repository.dart';


class LoginUseCase {
  final AuthRepository repository;

  const LoginUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String password) {
    return repository.login(email, password);
  }
}
