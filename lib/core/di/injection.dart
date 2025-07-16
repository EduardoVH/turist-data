import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
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
  // HTTP Client (Dio)
  sl.registerLazySingleton(() => Dio());

  // === LOGIN ===

  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Use case
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(sl()));

  // === REGISTER ===

  // DataSource
  sl.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(remoteDataSource: sl()),
  );

  // Use case
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  // Bloc
  sl.registerFactory(() => RegisterBloc(registerUseCase: sl()));
}
