import 'package:aplicacion2/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      final result = await loginUseCase(event.email, event. password);

      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (_) => emit(AuthSuccess()),
      );
    });
  }
}