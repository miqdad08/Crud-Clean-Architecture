import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../core/resources/failure.dart';

abstract class UserRepository {
  Future<Either<Failure,List<UserEntity>>> getUsers();
  Future<Either<Failure, String>> addUser(UserEntity user);
  Future<Either<Failure, String>> removeUser(UserEntity user);
  Future<Either<Failure, String>> updateUser(UserEntity user);
}