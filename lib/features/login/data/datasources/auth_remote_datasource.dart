import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/features/login/data/models/user_model.dart';

class AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSource(this.client);

  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('http://44.207.222.107:8000/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }
}
