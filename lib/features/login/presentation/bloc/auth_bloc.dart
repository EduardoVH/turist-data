import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    final result = await loginUseCase(event.correo, event.password);

    await result.fold(
          (failure) async {
        emit(AuthFailure(failure.message));
      },
          (token) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token); // Guardar token

        print('Correo: ${event.correo}');
        emit(AuthSuccess(token, event.correo));
      },
    );
  }
}
