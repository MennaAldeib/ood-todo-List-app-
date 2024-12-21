/*


query 1 Query: Get Tasks Due This Week

Future<List<Task>> getTasksDueThisWeek() async {
  final box = await Hive.openBox<Task>('taskBox');
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(Duration(days: 6));

  return box.values.where((task) =>
    task.dueDate.isAfter(startOfWeek) && task.dueDate.isBefore(endOfWeek)
  ).toList();
}

query 2  Query: Get Tasks by Status
Future<List<Task>> getTasksByStatus(String status) async {
  final box = await Hive.openBox<Task>('taskBox');
  return box.values.where((task) => task.status == status).toList();
}



query 3 Count Overdue Tasks
Future<int> countOverdueTasks() async {
  final box = await Hive.openBox<Task>('taskBox');
  return box.values.where((task) => task.dueDate.isBefore(DateTime.now())).length;
}

 */