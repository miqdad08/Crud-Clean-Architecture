import 'dart:convert';
import 'package:crud_clean_architecture/core/constant/constant.dart';
import 'package:crud_clean_architecture/features/data/models/user.dart';
import 'package:http/http.dart' as http;
import '../../../../core/resources/failure.dart';
import '../../../../core/resources/http_response.dart';

class UsersService {
  final http.Client httpClient;

  UsersService(this.httpClient);

  Future<HttpResponse<List<UserModel>>> getUsers() async {
    final response = await httpClient.get(
      Uri.parse(
        '$baseUrl/users',
      ),
    );
    if (response.statusCode == 200) {
      final dataUsers = jsonDecode(response.body)['data'];
      List<UserModel> value =
          dataUsers.map<UserModel>((user) => UserModel.fromJson(user)).toList();
      final httpResponse = HttpResponse(value, response);
      return httpResponse;
    } else {
      throw Failure(
        message: jsonDecode(response.body)['message'] ?? 'Failed Get User',
      );
    }
  }

  Future<HttpResponse<String>> removeUser(int userId) async {
    final response = await httpClient.delete(
      Uri.parse(
        '$baseUrl/users/$userId',
      ),
    );
    if (response.statusCode == 200) {
      String value = 'Success Add User';
      final httpResponse = HttpResponse(value, response);
      return httpResponse;
    } else {
      throw Failure(
          message:
              jsonDecode(response.body)['message'] ?? 'Failed Remove User');
    }
  }

  Future<HttpResponse<String>> addUser(UserModel user) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/users'),
      body: user.toJson(),
    );
    if (response.statusCode == 200) {
      String value = 'Success Add User';
      final httpResponse = HttpResponse(value, response);
      return httpResponse;
    } else {
      return throw Failure(
          message: jsonDecode(response.body)['message'] ?? 'Failed Add User');
    }
  }

  Future<HttpResponse<String>> updateUser(UserModel user) async {
    final response = await httpClient.post(
      Uri.parse(
        '$baseUrl/users/${user.id}',
      ),
      body: user.toJson(),
    );
    if (response.statusCode == 200){
       String value = 'Success Edit User';
       final httpResponse = HttpResponse(value, response);
       return httpResponse;
    } else {
      throw Failure(
          message: jsonDecode(response.body)['message'] ?? 'Failed Edit User');
    }
  }
}
