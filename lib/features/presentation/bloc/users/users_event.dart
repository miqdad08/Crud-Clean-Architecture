part of 'users_bloc.dart';

@immutable
abstract class UsersEvent extends Equatable{
  final UserEntity? user;

  const UsersEvent({this.user});


  @override
  List<Object?> get props => [user];
}

class GetUsers extends UsersEvent {
  const GetUsers();
}

class RemoveUser extends UsersEvent {
  const RemoveUser(UserEntity user) : super(user: user);
}

class AddUser extends UsersEvent {
  const AddUser(UserEntity user) : super(user: user);
}

class UpdateUser extends UsersEvent {
  const UpdateUser(UserEntity user) : super(user: user);
}
