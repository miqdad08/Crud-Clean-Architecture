import 'package:crud_clean_architecture/core/resources/failure.dart';
import 'package:crud_clean_architecture/core/usecase/usecase.dart';
import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:crud_clean_architecture/features/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUsersUseCase implements UseCase<Either<Failure, List<UserEntity>>,void>{

  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call({void params}) {
    return _userRepository.getUsers();
  }

}