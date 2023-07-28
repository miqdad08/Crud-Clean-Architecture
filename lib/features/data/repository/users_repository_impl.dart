import 'dart:io';

import 'package:crud_clean_architecture/core/resources/failure.dart';
import 'package:crud_clean_architecture/features/data/data_source/remote/users_service.dart';
import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UsersService _usersService;

  UserRepositoryImpl(this._usersService);

  @override
  Future<Either<Failure, String>> addUser() {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final httpResponse = await _usersService.getUsers();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Right(
          httpResponse.data.map((model) => model.toEntity()).toList(),
        );
      } else {
        return Left(
          Failure(
            message: httpResponse.response.body,
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> removeUser(UserEntity user) {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateUser(UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
