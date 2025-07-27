import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'eventos_remote_datasource.dart';

class EventosRemoteDataSourceImpl implements EventosRemoteDataSource {
  final Dio dio = GetIt.I<Dio>();

  @override
  Future<List<Map<String, dynamic>>> getEventosEspeciales() async {
    final response = await dio.get('https://turistdata-back.onrender.com/api/eventosespeciales');
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data);
    } else {
      throw Exception('Error al obtener eventos especiales');
    }
  }
}
