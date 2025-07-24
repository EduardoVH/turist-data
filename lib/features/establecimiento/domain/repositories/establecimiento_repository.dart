import '../entities/establecimiento_entity.dart';

abstract class EstablecimientoRepository {
  Future<List<EstablecimientoEntity>> getEstablecimientos();
}
