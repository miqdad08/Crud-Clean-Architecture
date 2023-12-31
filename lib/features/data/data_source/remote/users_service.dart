import 'dart:convert';
import 'package:crud_clean_architecture/core/constant/constant.dart';
import 'package:crud_clean_architecture/features/data/data_source/remote/user_data_source.dart';
import 'package:crud_clean_architecture/features/data/models/user.dart';
import 'package:http/http.dart' as http;
import '../../../../core/resources/failure.dart';
import '../../../../core/resources/http_response.dart';

class UserService implements UserDataSource {
  final http.Client  httpClient;

  UserService(this.httpClient);

  var headers = {
    'Content-Type': 'application/json',
  };

  @override
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

  @override
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

  @override
  Future<HttpResponse<String>> addUser(UserModel user) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/users'),
      body: jsonEncode(user.toJson()),
      headers: headers,
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

  @override
  Future<HttpResponse<String>> updateUser(UserModel user) async {
    final response = await httpClient.post(
      Uri.parse(
        '$baseUrl/users/${user.id}',
      ),
      body: jsonEncode(user.toJson()),
      headers: headers,
    );
    if (response.statusCode == 200) {
      String value = 'Success Edit User';
      final httpResponse = HttpResponse(value, response);
      return httpResponse;
    } else {
      throw Failure(
          message: jsonDecode(response.body)['message'] ?? 'Failed Edit User');
    }
  }
}
