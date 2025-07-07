import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSource(this.client);

  Future<String> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('https://tu-api.com/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['acceso'];
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }
}
