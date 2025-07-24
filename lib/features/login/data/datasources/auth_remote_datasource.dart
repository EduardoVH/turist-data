import 'package:dio/dio.dart';
import 'package:turist_data/core/session/usuario_session.dart';

abstract class AuthRemoteDataSource {
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
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        // ✅ Imprime la respuesta para verificar estructura
        print('Respuesta completa: ${response.data}');

        // ✅ Accede directamente si los datos vienen en el cuerpo
        UsuarioSession.nombre = response.data['nombre'] ?? '';
        UsuarioSession.correo = response.data['correo'] ?? '';

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
