import 'package:aplicacion2/features/login/data/datasources/auth_remote_datasource.dart';
import 'package:aplicacion2/features/login/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
// import '../../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      final result = await remoteDataSource.login(email, password);
      if (result == 'valido') {
        return Right(null);
      } else {
        return Left(Failure('Credenciales inválidas'));
      }
    } catch (e) {
      return Left(Failure('Error de red'));
    }
  }
}
