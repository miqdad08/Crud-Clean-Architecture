import 'dart:convert';

import 'package:crud_clean_architecture/core/constant/constant.dart';
import 'package:crud_clean_architecture/features/data/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/resources/failure.dart';

class UsersService {
  final http.Client httpClient;

  UsersService(this.httpClient);

  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      final response = await httpClient.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        final dataUsers = jsonDecode(response.body)['data'];
        return Right(List<UserModel>.from(
            dataUsers.map((user) => UserModel.fromJson(user))));
      } else {
        return Left(Failure(message: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      rethrow;
    }
  }


}
