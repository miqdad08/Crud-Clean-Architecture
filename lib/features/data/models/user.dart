import '../../domain/entities/user.dart';

class UserModel {
  final int? id;
  final String? name;
  final String? email;

  const UserModel({this.id, this.name, this.email});

  factory UserModel.fromJson(Map<String, dynamic>json){
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email']
    );
  }

  UserEntity toEntity(){
    return UserEntity(
      id: id,
      name: name,
      email: email
    );
  }

  factory UserModel.fromEntity(UserEntity entity){
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email
    );
  }
}