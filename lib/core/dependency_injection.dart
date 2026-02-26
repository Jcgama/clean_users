import 'package:clean_users/core/api/api_client.dart';
import 'package:clean_users/features/users/data/datasource/users_remote_datasource.dart';
import 'package:clean_users/features/users/data/repositories/users_repository_impl.dart';
import 'package:clean_users/features/users/domain/repositories/users_repository.dart';
import 'package:clean_users/features/users/domain/usecases/get_users.dart';
import 'package:clean_users/features/users/presentation/bloc/users_bloc.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton(ApiClient());
  getIt.registerSingleton(getIt<ApiClient>().getDio());

  // Use cases
  getIt.registerLazySingleton(() => GetUsers(getIt()));

  // Data sources
  getIt.registerLazySingleton<UsersRemoteDatasource>(() => UsersRemoteDatasource(getIt()));

  // Repository
  getIt.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(getIt()));
  
  // Bloc
  getIt.registerFactory(() => UsersBloc(getUsers: getIt()));
}