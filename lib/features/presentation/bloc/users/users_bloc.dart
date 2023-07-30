import 'package:bloc/bloc.dart';
import 'package:crud_clean_architecture/core/resources/failure.dart';
import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:crud_clean_architecture/features/domain/usecases/add_user.dart';
import 'package:crud_clean_architecture/features/domain/usecases/remove_user.dart';
import 'package:crud_clean_architecture/features/domain/usecases/update_user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/get_users.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase _getUsersUseCase;
  final RemoveUserUseCase _removeUserUseCase;
  final AddUserUseCase _addUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  UsersBloc(
    this._getUsersUseCase,
    this._removeUserUseCase,
    this._addUserUseCase,
    this._updateUserUseCase,
  ) : super(const UsersLoading()) {
    on<GetUsers>(onGetUsers);
    on<RemoveUser>(onRemoveUser);
    on<AddUser>(onAddUser);
    on<UpdateUser>(onUpdateUser);
  }

  void onGetUsers(GetUsers event, Emitter<UsersState> emit) async {
    final users = await _getUsersUseCase();
    users.fold(
      (failure) => emit(UsersFailed(failure)),
      (users)  => emit(UsersSuccess(users)),
    );
  }

  void onRemoveUser(RemoveUser event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());
    final removedUser = await _removeUserUseCase(params: event.user);
    removedUser.fold(
      (failure) => emit(UsersFailed(failure)),
      (message) => emit(UserUpdated(message)),
    );
  }

  void onAddUser(AddUser event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());
    final addUser =  await _addUserUseCase(params: event.user);
    addUser.fold(
      (failure) => emit(UsersFailed(failure)),
      (message) => emit(UserUpdated(message)),
    );
  }

  void onUpdateUser(UpdateUser event, Emitter<UsersState> emit) async {
    emit(const UsersLoading());
    final updateUser = await _updateUserUseCase(params: event.user);
    updateUser.fold(
      (failure) => emit(UsersFailed(failure)),
      (message) => emit(UserUpdated(message)),
    );
  }
}
