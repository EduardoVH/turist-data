import '../../domain/repositories/eventos_repository.dart';
import '../datasource/eventos_remote_datasource.dart';

class EventosRepositoryImpl implements EventosRepository {
  final EventosRemoteDataSource dataSource;

  EventosRepositoryImpl(this.dataSource);

  @override
  @override
  Future<List<Map<String, dynamic>>> getEventosEspeciales() async {
    return await dataSource.getEventosEspeciales(); // ✅ también espera resultado
  }

}
