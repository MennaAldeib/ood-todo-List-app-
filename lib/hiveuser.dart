
import 'package:hive/hive.dart';

part 'hiveuser.g.dart' ;

@HiveType(typeId: 1)
class User {

  @HiveField(0)
  String userID;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  User({
    required this.userID,
    required this.name,
    required this.email,
    required this.password,
  });
}


