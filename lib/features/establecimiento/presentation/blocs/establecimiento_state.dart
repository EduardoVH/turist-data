import 'package:equatable/equatable.dart';
import '../../domain/entities/establecimiento_entity.dart';

abstract class EstablecimientoState extends Equatable {
  const EstablecimientoState();

  @override
  List<Object> get props => [];
}

class EstablecimientoInitial extends EstablecimientoState {}

class EstablecimientoLoading extends EstablecimientoState {}

class EstablecimientoLoaded extends EstablecimientoState {
  final List<EstablecimientoEntity> establecimientos;

  const EstablecimientoLoaded(this.establecimientos);

  @override
  List<Object> get props => [establecimientos];
}

class EstablecimientoError extends EstablecimientoState {
  final String message;

  const EstablecimientoError(this.message);

  @override
  List<Object> get props => [message];
}
