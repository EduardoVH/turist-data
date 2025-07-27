import '../models/establecimiento_model.dart';

abstract class EstablecimientoRemoteDataSource {
  Future<List<Establecimiento>> fetchEstablecimientos();
}
