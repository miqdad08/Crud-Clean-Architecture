import 'dart:io';

import 'package:crud_clean_architecture/core/resources/failure.dart';
import 'package:crud_clean_architecture/features/data/data_source/remote/users_service.dart';
import 'package:crud_clean_architecture/features/data/models/user.dart';
import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _usersService;

  UserRepositoryImpl(this._usersService);

  @override
  Future<Either<Failure, String>> addUser(UserEntity userEntity) async {
    try {
      final httpResponse =
      await _usersService.addUser(UserModel.fromEntity(userEntity));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Right(httpResponse.data);
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
  Future<Either<Failure, String>> removeUser(UserEntity userEntity) async {
    try {
      final httpResponse = await _usersService.removeUser(userEntity.id!);
      if(httpResponse.response.statusCode == HttpStatus.ok){
        return Right(httpResponse.data);
      }else{
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
  Future<Either<Failure, String>> updateUser(UserEntity userEntity) async {
    try {
      final httpResponse = await _usersService.updateUser(UserModel.fromEntity(userEntity));
      if(httpResponse.response.statusCode == HttpStatus.ok){
        return Right(httpResponse.data);
      }else{
        return Left(
          Failure(
            message: httpResponse.response.body,
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          message: 'Failed Update User',
        ),
      );
    }
  }
}
