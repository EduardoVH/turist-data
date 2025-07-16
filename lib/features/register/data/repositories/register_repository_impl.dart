import 'package:dartz/dartz.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_remote_datasource.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;

  RegisterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, String>> register(
      String email, String password) async {
    try {
      final message = await remoteDataSource.register(email, password);
      return Right(message);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
