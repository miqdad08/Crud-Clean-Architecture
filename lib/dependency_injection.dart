
import 'dart:io';

import 'package:crud_clean_architecture/features/data/data_source/remote/users_service.dart';
import 'package:crud_clean_architecture/features/data/repository/users_repository_impl.dart';
import 'package:crud_clean_architecture/features/domain/usecases/add_user.dart';
import 'package:crud_clean_architecture/features/domain/usecases/get_users.dart';
import 'package:crud_clean_architecture/features/domain/usecases/remove_user.dart';
import 'package:crud_clean_architecture/features/domain/usecases/update_user.dart';
import 'package:crud_clean_architecture/features/presentation/bloc/users/users_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {

  // http
  locator.registerSingleton<HttpClient>(HttpClient());

  //Service
  locator.registerSingleton(UsersService(locator()));

  //Repository
  locator.registerSingleton(UserRepositoryImpl(locator()));

  //UseCase
  locator.registerSingleton<GetUsersUseCase>(GetUsersUseCase(locator()));
  locator.registerSingleton<AddUserUseCase>(AddUserUseCase(locator()));
  locator.registerSingleton<RemoveUserUseCase>(RemoveUserUseCase(locator()));
  locator.registerSingleton<UpdateUserUseCase>(UpdateUserUseCase(locator()));

  //Blocs
  locator.registerFactory<UsersBloc>(() => UsersBloc(locator(), locator(), locator(), locator()));

}
