import 'dart:convert';

import 'package:crud_clean_architecture/core/constant/constant.dart';
import 'package:crud_clean_architecture/features/data/models/user.dart';
import 'package:http/http.dart' as http;
import '../../../../core/resources/failure.dart';

class UsersService {
  final http.Client httpClient;

  UsersService(this.httpClient);

  Future<List<UserModel>> getUsers() async {
    final response = await httpClient.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final dataUsers = jsonDecode(response.body)['data'];
      return List<UserModel>.from(
          dataUsers.map((user) => UserModel.fromJson(user)));
    } else {
      throw Failure(
          message: jsonDecode(response.body)['message'] ?? 'Failed Get User');
    }
  }

  Future<String> removeUser(int userId) async {
    final response =
        await httpClient.delete(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return 'Success Remove User';
    } else {
      throw Failure(
          message:
              jsonDecode(response.body)['message'] ?? 'Failed Remove User');
    }
  }

  Future<String> addUser(UserModel user) async {
    final response = await httpClient.post(
      Uri.parse(
        '$baseUrl/users',
      ),
      body: user.toJson(),
    );
    if (response.statusCode == 200) {
      return 'Success Add User';
    } else {
      throw Failure(
          message: jsonDecode(response.body)['message'] ?? 'Failed Add User');
    }
  }

  Future<String> editUser(UserModel user) async {
    final response = await httpClient.post(
      Uri.parse(
        '$baseUrl/users/${user.id}',
      ),
      body: user.toJson(),
    );
    if (response.statusCode == 200) {
      return 'Success Edit User';
    } else {
      throw Failure(
          message: jsonDecode(response.body)['message'] ?? 'Failed Edit User');
    }
  }
}
