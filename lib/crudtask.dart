
// task_service.dart
import 'package:hive/hive.dart';
import 'hivetask.dart';

class TaskService {
  static const String _boxName = 'taskBox';

  // open box
  Future<Box<Task>> _openBox() async {
    return await Hive.openBox<Task>(_boxName);
  }

  // create operation (Create)
  Future<void> createTask(Task task) async {
    final box = await _openBox();
    await box.put(task.taskID, task);
  }

  // retrieve & read operation  (Read)
  Future<List<Task>> getTasks() async {
    final box = await _openBox();
    return box.values.toList();
  }

  // update operation (Update)
  Future<void> updateTask(String taskID, Task updatedTask) async {
    final box = await _openBox();
    await box.put(taskID, updatedTask);
  }
  // delete task  operation (Delete)
  Future<void> deleteTask(String taskID) async {
    final box = await _openBox();
    await box.delete(taskID);
  }
}
