
import 'package:hive/hive.dart';

 part 'hivetask.g.dart' ;

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String taskID;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  String status;

  @HiveField(5)
  DateTime dueTime;

  @HiveField(6)
  String categoryID;

  Task({
    required this.taskID,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.dueTime,
    required this.categoryID, //foreign key
  });
}



