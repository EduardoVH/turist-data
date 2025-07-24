import 'package:flutter_bloc/flutter_bloc.dart';
import 'establecimiento_event.dart';
import 'establecimiento_state.dart';
import '../../domain/usecases/get_establecimientos_usecase.dart';






class EstablecimientoBloc extends Bloc<EstablecimientoEvent, EstablecimientoState> {
  final GetEstablecimientosUseCase getEstablecimientos;


  EstablecimientoBloc(this.getEstablecimientos) : super(EstablecimientoInitial()) {
    on<LoadEstablecimientos>((event, emit) async {
      emit(EstablecimientoLoading());
      try {
        final establecimientos = await getEstablecimientos();
        emit(EstablecimientoLoaded(establecimientos));
      } catch (e) {
        emit(EstablecimientoError(e.toString()));
      }
    });
  }
}
