import 'package:aplicacion2/core/error/failure.dart';
import 'package:aplicacion2/features/login/data/datasources/auth_remote_datasource.dart';
import 'package:aplicacion2/features/login/data/models/user_model.dart';
import 'package:aplicacion2/features/login/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserModel>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return Right(user);
    } on Exception catch (e) {
      return Left(Failure('Login fallido: ${e.toString()}'));
    }
  }
}