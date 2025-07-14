import 'package:aplicacion2/core/error/failure.dart';
import 'package:aplicacion2/features/login/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login(String email, String password);
}