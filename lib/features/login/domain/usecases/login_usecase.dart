import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String password) {
    return repository.login(email, password);
  }
}
