import 'package:flutter_bloc/flutter_bloc.dart';
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
        final eventos = await getEventos();
        emit(EventosLoaded(eventos));
      } catch (e) {
        emit(EventosError(e.toString()));
      }
    });
  }
}
