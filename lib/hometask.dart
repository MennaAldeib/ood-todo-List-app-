import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/UpdateTaskPage.dart';
import 'package:todoapp/splash.dart';
import 'Addtaskpage.dart';
import 'hivetask.dart';


class MyTasks extends StatefulWidget {
  const MyTasks({super.key});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  late Box<Task> taskBox; //بنعرفها )hive ) عشان تتخزن
  @override
  void initState() { // بستدعي اوامر hive و تبدأ تشتغل
    super.initState();
    _openBox();
  }
   // bnft7 L database  قبل ما بنستخدمها لازم نفتح ال box
  Future<void> _openBox() async {
    taskBox = await Hive.openBox<Task>('taskBox');
    setState(() {});   // update user interface l tasks
  }
  void _deleteTask(String taskId) async {
    await taskBox.delete(taskId);
    setState(() {}); // Refresh the UI after deleting a task
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task deleted successfully')),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text(''),
      ),

      drawer: Drawer(
        width: 197,
        backgroundColor: Color(0Xff465A65),
        child: ListView(
          children: [
            Container(
              height: 110,
              color: Color(0Xff465A65),
              child: Center(
                child: Text(
                  'Welcome Jehan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Profile Item
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0Xff465A65),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_circle, color: Colors.white, size: 30),
                  SizedBox(width: 10),
                  const Text(
                    'Your Profile',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            // Settings Item
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0Xff465A65),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.settings, color: Colors.white, size: 30),
                  SizedBox(width: 10),
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0Xff465A65),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.inbox, color: Colors.white, size: 30),
                  SizedBox(width: 10),
                  const Text(
                    'InBox',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0Xff465A65),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.favorite, color: Colors.white, size: 30),
                  SizedBox(width: 10),
                  const Text(
                    'Favorites',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
            );
          },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0Xff465A65),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Row(
                children: [
                  Icon(Icons.logout_outlined, color: Colors.white, size: 30),
                  SizedBox(width: 10),
                  const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
        ),
          ],
        ),
      ),
      // Body
      body: Column(
        children: [
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 101,
                height: 12,
                color: const Color(0XffFCCA21),
              ),
              const Text(
                'My Tasks',
                style: TextStyle(
                  color: Color(0XffF273236),
                  fontFamily: "Poppins-Bold",
                  fontSize: 40,
                ),
              ),
              Container(
                width: 101,
                height: 12,
                color: const Color(0XffFCCA21),
              ),
            ],
          ),
          const SizedBox(height: 0), // Add some spacing
          Expanded( // Use Expanded here
            child: FutureBuilder(
              future: _openBox(),
              builder: (context, snapshot) {
                final tasks = taskBox.values.toList();
                if (tasks.isEmpty) {
                  return Center(
                    child: Container(
                      width: 376,
                      height: 376,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/to do image.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }
                  // represent the tasks // retrieve mn l db
                return ListView.builder(
                  itemCount: taskBox.values.length,
                  itemBuilder: (context, index) {
                    final task = taskBox.getAt(index);
                    return InkWell(
                      onTap: () {
                        if (task != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateTask(task: task, taskIndex: index), // Pass the task to the UpdateTaskPage
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black, // Stroke color
                            width: 1, // Stroke width
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task?.title ?? 'Untitled Task',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    task?.description ?? '',
                                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Due: ${task?.dueDate.toString().split(' ')[0]}',
                                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                if (task != null) _deleteTask(task.taskID);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );


              },
            ),
          ),  //الصورة
          const SizedBox(height: 5), // Optional for spacing
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskPage()),
              );
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0Xff465A65),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40), // Optional for spacing

        ],
      ),
    );
  }
}
