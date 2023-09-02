import '../../models/user.dart';

abstract class FirebaseUserDataSource {
  Future<List<UserModel>> getUsers();

  Future<String> addUser(UserModel user);

  Future<String> updateUser(UserModel user);

  Future<String> removeUser(int idUser);
}
