import 'package:aplicacion2/features/login/domain/repositories/auth_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/login/data/datasources/auth_remote_datasource.dart';
import 'features/login/data/repositories/auth_repository_impl.dart';
import 'features/login/domain/repositories/auth_repository.dart';
import 'features/login/domain/usecases/login_usecase.dart';
import 'features/login/presentation/blocs/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AuthBloc(sl()));

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Datasources
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}
