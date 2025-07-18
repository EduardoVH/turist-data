import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  /// Realiza el login y retorna el token si es exitoso.
  Future<String> login(String correo, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<String> login(String correo, String password) async {
    try {
      final response = await dio.post(
        'https://turistdata-back.onrender.com/api/turistas/login',
        data: {
          'correo': correo,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // ✅ Extrae el token correctamente
        return response.data['token'];
      } else if (response.statusCode == 401) {
        throw Exception('Credenciales incorrectas');
      } else {
        throw Exception(response.data['error'] ?? 'Error en el servidor');
      }
    } on DioError catch (e) {
      final errorMessage = e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Error en la petición';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Error inesperado: ${e.toString()}');
    }
  }
}
