import 'package:equatable/equatable.dart';

abstract class EstablecimientoEvent extends Equatable {
  const EstablecimientoEvent();

  @override
  List<Object> get props => [];
}

class LoadEstablecimientos extends EstablecimientoEvent {}
