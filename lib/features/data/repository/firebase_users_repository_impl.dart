import 'package:crud_clean_architecture/core/resources/failure.dart';
import 'package:crud_clean_architecture/features/data/data_source/firebase/firebase_user_service.dart';
import 'package:crud_clean_architecture/features/data/models/user.dart';
import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repository/user_repository.dart';

class FirebaseUserRepositoryImpl implements UserRepository {
  final FirebaseUserService _usersService;

  FirebaseUserRepositoryImpl(this._usersService);

  @override
  Future<Either<Failure, String>> addUser(UserEntity user) async {
    try {
      final response = await _usersService.addUser(UserModel.fromEntity(user));
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(
        Failure(message: e.message ?? ''),
      );
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async{
    try {
      final response = await _usersService.getUsers();
      return Right(response.map((model) => model.toEntity()).toList());
    } on FirebaseException catch (e) {
      return Left(
        Failure(message: e.message ?? ''),
      );
    }
  }

  @override
  Future<Either<Failure, String>> removeUser(UserEntity user) async{
    try {
      final response = await _usersService.removeUser(user.id!);
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(
        Failure(message: e.message ?? ''),
      );
    }
  }

  @override
  Future<Either<Failure, String>> updateUser(UserEntity user) async{
    try {
      final response = await _usersService.updateUser(UserModel.fromEntity(user));
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(
        Failure(message: e.message ?? ''),
      );
    }
  }
}
