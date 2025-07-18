import 'package:dio/dio.dart';

abstract class RegisterRemoteDataSource {
  Future<String> register(String nombre, String email, String password);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final Dio dio;

  RegisterRemoteDataSourceImpl(this.dio);

  @override
  Future<String> register(String nombre, String email, String password) async {
    try {
      final response = await dio.post(
        'https://turistdata-back.onrender.com/api/turistas',
        data: {
          'nombre': nombre,
          'correo': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['message'] ?? 'Usuario registrado exitosamente';
      } else if (response.statusCode == 400) {
        final errorMessage = response.data['message'] ??
            response.data['error'] ??
            'Datos de registro inválidos';
        throw Exception(errorMessage);
      } else if (response.statusCode == 409) {
        throw Exception('El correo ya está registrado');
      } else {
        final errorMessage = response.data['message'] ??
            response.data['error'] ??
            'Error en el servidor';
        throw Exception(errorMessage);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorMessage = e.response?.data['message'] ??
            e.response?.data['error'] ??
            'Error en la petición';
        throw Exception(errorMessage);
      }
      throw Exception('Error de conexión: No se pudo conectar al servidor');
    } catch (e) {
      throw Exception('Error inesperado: ${e.toString()}');
    }
  }
}
