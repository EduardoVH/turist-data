import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/error/failure.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final token = await remoteDataSource.login(email, password);
      // No uses 'as String', ya que token ya debe ser String.
      return Right(token);
    } catch (e) {
      return Left(Failure('Login fallido: ${e.toString()}'));
    }
  }
}
