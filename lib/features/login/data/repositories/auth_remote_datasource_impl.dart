import '../datasources/auth_remote_datasource.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await dio.post(
        'administrador/login',
        data: {
          'correo': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token']; // Devuelve solo el token
      } else {
        throw Exception(response.data['error'] ?? 'Error desconocido');
      }
    } catch (e) {
      rethrow;
    }
  }
}
