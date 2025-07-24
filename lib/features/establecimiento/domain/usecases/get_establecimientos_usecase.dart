import '../entities/establecimiento_entity.dart';
import '../repositories/establecimiento_repository.dart';

class GetEstablecimientosUseCase {
  final EstablecimientoRepository repository;

  GetEstablecimientosUseCase(this.repository);

  Future<List<EstablecimientoEntity>> call() async {
    return await repository.getEstablecimientos();
  }
}

