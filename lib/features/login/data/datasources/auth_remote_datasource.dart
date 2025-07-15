import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<String> login(String email, String password) async {
    // SIMULAR respuesta exitosa del backend
    await Future.delayed(const Duration(seconds: 1)); // para simular delay
    if (email == "test@test.com" && password == "test") {
      return "fake_token_123456"; // token falso
    } else {
      throw Exception("Credenciales incorrectas (modo fake)");
    }
  }
}
