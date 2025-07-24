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
      // En caso de error (failure)
          (failure) {
        emit(AuthFailure(failure.message));
      },

      // En caso de éxito (token)
          (token) {
        print('Correo: ${event.correo}');
        // Emitimos token y el correo que viene en el evento para mostrarlo luego
        emit(AuthSuccess(token, event.correo));
      },
    );
  }
}
