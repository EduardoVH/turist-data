import '../datasources/establecimiento_remote_data_source.dart';
import '../../domain/entities/establecimiento_entity.dart';
import '../../domain/repositories/establecimiento_repository.dart';

class EstablecimientoRepositoryImpl implements EstablecimientoRepository {
  final EstablecimientoRemoteDataSource remoteDataSource;

  EstablecimientoRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<EstablecimientoEntity>> getEstablecimientos() async {
    final models = await remoteDataSource.fetchEstablecimientos();
    return models.map((e) => EstablecimientoEntity(
      id: e.id,
      nombre: e.nombre,
      direccion: e.direccion,
      categoria: e.categoria,
      imagen: e.imagen,
      horario: e.horario,
      precio: e.precio,
      latitude: e.latitude,      // ✅ agregar coordenadas
      longitude: e.longitude,
    )).toList();
  }
}
