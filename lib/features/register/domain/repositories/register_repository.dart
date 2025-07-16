import 'package:dartz/dartz.dart';

abstract class RegisterRepository {
  Future<Either<Exception, String>> register(String email, String password);
}
