import 'package:crud_clean_architecture/features/data/models/user.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../core/resources/failure.dart';
import 'firebase_user_data_source.dart';

class FirebaseUserService implements FirebaseUserDataSource {
  final DatabaseReference _userReference = FirebaseDatabase.instance.ref();

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final DatabaseEvent snapshot =
          await _userReference.child('users').orderByChild('id').once();
      print('data ${snapshot.snapshot.value}');
      final value = Map<String, dynamic>.from(
          snapshot.snapshot.value! as Map<Object?, Object?>);
      if (snapshot.snapshot.value != null) {
        final Map<dynamic, dynamic> data = value;
        final List<UserModel> users = [];
        final sortedData = data.entries.toList()
          ..sort((a, b) => b.value['id'].compareTo(a.value['id']));

        for (var entry in sortedData) {
          users.add(
            UserModel(
              id: entry.value['id'] ?? 0,
              name: entry.value['name'] ?? '',
              email: entry.value['email'] ?? '',
            ),
          );
        }
        return users;
      } else {
        return [];
      }
    } catch (e) {
      return throw Failure(message: 'Failed Get User');
    }
  }

  @override
  Future<String> addUser(UserModel user) async {
    try {
      final loadUsers = await getUsers();
      final usersId = loadUsers.first.id! + 1;
      final userJson = UserModel(
        id: usersId,
        name: user.name,
        email: user.email,
      );
      if (userJson.toJson().isEmpty) {
        return throw Failure(message: 'User Data is Empty');
      }
      final String userId = _userReference.child('users').push().key ?? '';
      await _userReference.child('users').child(userId).set(userJson.toJson());
      return userId;
    } catch (e) {
      return throw Failure(message: 'Failed Add User');
    }
  }

  @override
  Future<String> removeUser(int idUser) async {
    try {
      final DatabaseEvent snapshot = await _userReference
          .child('users')
          .orderByChild('id')
          .equalTo(idUser)
          .once();
      final value = Map<String, dynamic>.from(
          snapshot.snapshot.value! as Map<Object?, Object?>);
      if (snapshot.snapshot.value != null) {
        final Map<dynamic, dynamic> data = value;
        final String keyToRemove = data.keys.first;
        await _userReference.child('users').child(keyToRemove).remove();
        String message = 'Success Remove User';
        return message;
      }
      return throw Failure(message: 'Failed Remove User');
    } catch (e) {
      return throw Failure(message: 'Failed Remove User');
    }
  }

  @override
  Future<String> updateUser(UserModel user) async {
    try {
      final DatabaseEvent snapshot = await _userReference
          .child('users')
          .orderByChild('id')
          .equalTo(user.id)
          .once();
      final value = Map<String, dynamic>.from(
          snapshot.snapshot.value! as Map<Object?, Object?>);
      if (snapshot.snapshot.value != null) {
        final Map<dynamic, dynamic> data = value;
        final String keyToUpdate = data.keys.first;
        await _userReference
            .child('users')
            .child(keyToUpdate)
            .update(user.toJson());
        String message = 'User with ID ${user.id} updated successfully';
        return message;
      }
      return throw Failure(message: 'Failed Remove User');
    } catch (e) {
      return throw Failure(message: 'Failed Remove User');
    }
  }
}
