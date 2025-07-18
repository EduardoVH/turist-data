import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:turist_data/features/login/data/datasources/auth_remote_datasource.dart';
import 'package:turist_data/features/login/data/repositories/auth_repository_impl.dart';
import 'package:turist_data/features/login/domain/repositories/auth_repository.dart';
import 'package:turist_data/features/login/domain/usecases/login_usecase.dart';
import 'package:turist_data/features/login/presentation/bloc/auth_bloc.dart';
import 'package:turist_data/features/register/data/datasources/register_remote_datasource.dart';
import 'package:turist_data/features/register/data/repositories/register_repository_impl.dart';
import 'package:turist_data/features/register/domain/repositories/register_repository.dart';
import 'package:turist_data/features/register/domain/usecases/register_usecase.dart';
import 'package:turist_data/features/register/presentation/blocs/register_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 🌐 Configuración personalizada de Dio con baseUrl del .env
  sl.registerLazySingleton(() => Dio(
    BaseOptions(
      baseUrl: dotenv.env['api'] ?? 'http://localhost:8000/',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  ));

  // === LOGIN ===
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerFactory(() => AuthBloc(sl()));

  // === REGISTER ===
  sl.registerLazySingleton<RegisterRemoteDataSource>(
        () => RegisterRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  sl.registerFactory(() => RegisterBloc(registerUseCase: sl()));
}
