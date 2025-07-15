import 'package:aplicacion2/data/datasources/auth_remote_datasource.dart';
import 'package:aplicacion2/data/repositories/auth_remote_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentation/blocs/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // HTTP Client (Dio)
  sl.registerLazySingleton(() => Dio());

  // DataSource (implementación)
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Use case
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // BLoC
  sl.registerFactory(() => AuthBloc(sl()));
}
