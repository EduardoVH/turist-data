import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/establecimiento_model.dart';
import 'establecimiento_remote_data_source.dart';

class EstablecimientoRemoteDataSourceImpl implements EstablecimientoRemoteDataSource {
  final String baseUrl;

  EstablecimientoRemoteDataSourceImpl({this.baseUrl = 'https://turistdata-back.onrender.com/api'});

  @override
  Future<List<Establecimiento>> fetchEstablecimientos() async {
    final response = await http.get(Uri.parse('$baseUrl/establecimientos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Establecimiento.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar establecimientos');
    }
  }
}
