
// user_service.dart
import 'package:hive/hive.dart';
import 'hiveuser.dart';

class UserService {
  static const String _boxName = 'userBox';

  // open box
  Future<Box<User>> _openBox() async {
    return await Hive.openBox<User>(_boxName);
  }

  //   create new user acc (Create) operation
  Future<void> createUser(User user) async {
    final box = await _openBox();
    await box.put(user.userID, user);
  }

  //  read all users (Read) operation
  Future<List<User>> getUsers() async {
    final box = await _openBox();
    return box.values.toList();
  }

  //  update user data   (Update) operation
  Future<void> updateUser(String userID, User updatedUser) async {
    final box = await _openBox();
    await box.put(userID, updatedUser);
  }


  // delete user (Delete) operation
  Future<void> deleteUser(String userID) async {
    final box = await _openBox();
    await box.delete(userID);
  }
}

