import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final int? id;
  final String? name;
  final String? email;

  const UserEntity({this.id, this.name, this.email});

  @override
  List<Object?> get props => [id, name, email];
}