import '../../../core/resources/http_response.dart';
import '../models/user.dart';

abstract class UserDataSource {
  Future<HttpResponse<List<UserModel>>> getUsers();
  Future<HttpResponse<String>> addUser(UserModel user);
  Future<HttpResponse<String>> updateUser(UserModel user);
  Future<HttpResponse<String>> removeUser(int idUser);
}
