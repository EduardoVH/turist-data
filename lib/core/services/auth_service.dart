import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turist_data/core/session/usuario_session.dart';

Future<void> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://turistdata-back.onrender.com/api/turistas/login'),
    body: {
      'correo': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    UsuarioSession.nombre = data['nombre'];
    UsuarioSession.correo = data['correo'];

    print('Usuario logueado: ${UsuarioSession.nombre}, ${UsuarioSession.correo}');
  } else {
    throw Exception('Login fallido');
  }
}
