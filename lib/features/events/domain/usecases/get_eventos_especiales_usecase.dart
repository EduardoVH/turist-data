import '../repositories/eventos_repository.dart';

class GetEventosEspecialesUseCase {
  final EventosRepository repository;

  GetEventosEspecialesUseCase(this.repository);

  Future<List<Map<String, dynamic>>> call() async {
    return await repository.getEventosEspeciales();
  }

}
