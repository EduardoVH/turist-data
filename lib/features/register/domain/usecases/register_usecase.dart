import 'package:dartz/dartz.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Exception, String>> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
