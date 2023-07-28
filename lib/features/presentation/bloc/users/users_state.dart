part of 'users_bloc.dart';

@immutable
abstract class UsersState extends Equatable {
  final List<UserEntity>? users;
  final Failure? error;

  const UsersState({this.users, this.error});

  @override
  List<Object?> get props => [users!, error!];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {
  const UsersLoading();
}

class UsersSuccess extends UsersState {
  const UsersSuccess(List<UserEntity> users) : super(users: users);
}

class UsersFailed extends UsersState {
  const UsersFailed(Failure error) : super(error: error);
}
