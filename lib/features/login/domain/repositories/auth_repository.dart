import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String email, String password);
}
