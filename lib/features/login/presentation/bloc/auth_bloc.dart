import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    /// ---------------------------
    /// MODO REAL (con backend)
    final result = await loginUseCase(event.correo, event.password);

    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (token) => emit(AuthSuccess(token)),
    );
    /// ---------------------------

    /// Si quieres usar modo fake para pruebas locales, comenta el bloque de arriba
    /*
    await Future.delayed(const Duration(seconds: 1)); // simula latencia
    if (event.correo == "test@test.com" && event.password == "test") {
      emit(AuthSuccess("fake_token_123456"));
    } else {
      emit(AuthFailure("Credenciales incorrectas (modo fake)"));
    }
    */
  }
}
