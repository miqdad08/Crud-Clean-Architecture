import 'package:crud_clean_architecture/features/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
  Future<List<UserEntity>> addUser();
  Future<String> removeUser(UserEntity user);
  Future<String> updateUser(UserEntity user);
}