import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> login(String correo, String password) async {
    try {
      final token = await remoteDataSource.login(correo, password);
      return Right(token);
    } catch (e) {
      return Left(Failure('Login fallido: ${e.toString()}'));
    }
  }
}
