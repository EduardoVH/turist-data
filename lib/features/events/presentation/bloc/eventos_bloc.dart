import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/usecases/get_eventos_especiales_usecase.dart';

abstract class EventosEvent {}
class LoadEventosEspeciales extends EventosEvent {}

abstract class EventosState {}
class EventosInitial extends EventosState {}
class EventosLoading extends EventosState {}
class EventosLoaded extends EventosState {
  final List<Map<String, dynamic>> eventos;
  EventosLoaded(this.eventos);
}
class EventosError extends EventosState {
  final String message;
  EventosError(this.message);
}

class EventosBloc extends Bloc<EventosEvent, EventosState> {
  final GetEventosEspecialesUseCase getEventos;

  EventosBloc(this.getEventos) : super(EventosInitial()) {
    on<LoadEventosEspeciales>((event, emit) async {
      emit(EventosLoading());
      try {
        final position = await _getCurrentPosition();
        final eventos = await getEventos();

        final eventosCercanos = eventos.where((evento) {
          final lat = double.tryParse(evento['latitud'].toString());
          final lon = double.tryParse(evento['longitud'].toString());
          if (lat == null || lon == null) return false;

          final distanceMeters = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            lat,
            lon,
          );

          return distanceMeters / 1000 <= 50; // 50 km máximo
        }).toList();

        emit(EventosLoaded(eventosCercanos));
      } catch (e) {
        emit(EventosError(e.toString()));
      }
    });
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Los servicios de ubicación están desactivados.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permisos de ubicación denegados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permisos de ubicación permanentemente denegados.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
