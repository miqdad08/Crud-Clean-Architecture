import 'package:crud_clean_architecture/core/resources/failure.dart';
import 'package:crud_clean_architecture/core/usecase/usecase.dart';
import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:crud_clean_architecture/features/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveUserUseCase implements UseCase<Either<Failure, String>, UserEntity>{

  final UserRepository _userRepository;

  RemoveUserUseCase(this._userRepository);

  @override
  Future<Either<Failure, String>> call({UserEntity? params}) {
    return _userRepository.removeUser(params!);
  }

}