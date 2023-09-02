
import 'package:crud_clean_architecture/features/data/data_source/remote/users_service.dart';
import 'package:crud_clean_architecture/features/data/repository/users_repository_impl.dart';
import 'package:crud_clean_architecture/features/domain/usecases/add_user.dart';
import 'package:crud_clean_architecture/features/domain/usecases/get_users.dart';
import 'package:crud_clean_architecture/features/domain/usecases/remove_user.dart';
import 'package:crud_clean_architecture/features/domain/usecases/update_user.dart';
import 'package:crud_clean_architecture/features/presentation/bloc/users/users_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'features/domain/repository/user_repository.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {

  // http
  locator.registerSingleton<http.Client>(http.Client());

  //Service
  locator.registerSingleton<UserService>(UserService(locator()));

  //Repository
  locator.registerSingleton<UserRepository>(UserRepositoryImpl(locator()));

  //UseCase
  locator.registerSingleton<GetUsersUseCase>(GetUsersUseCase(locator()));
  locator.registerSingleton<AddUserUseCase>(AddUserUseCase(locator()));
  locator.registerSingleton<RemoveUserUseCase>(RemoveUserUseCase(locator()));
  locator.registerSingleton<UpdateUserUseCase>(UpdateUserUseCase(locator()));

  //Blocs
  locator.registerFactory<UsersBloc>(() => UsersBloc(locator(), locator(), locator(), locator()));

}
