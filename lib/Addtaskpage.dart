import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'crudtask.dart';
import 'hivetask.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController  taskTitleController = TextEditingController();
  TextEditingController  categoryController = TextEditingController();
  TextEditingController  noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now(); // متغير لتخزين الوقت الي حطاه
  final TaskService taskService = TaskService(); // Initialize the task service


  // فتح الـ CupertinoDatePicker
  void _showCupertinoDatePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: 300,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date, // بحط التاريخ الي عايزاه
            initialDateTime: selectedDate,
            minimumDate: DateTime(2000),
            maximumDate: DateTime(2100),
            onDateTimeChanged: (DateTime date) {
              setState(() {
                selectedDate = date; //
                // بيحدث التواريخ
              });
            },
          ),
        );
      },
    );
  }
  // فتح الـ Time Picker
  void _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime; // تحديث الوقت الي حطاه
      });
    }
  }

  Future<void> _saveTask() async {
    try {
      final String id = DateTime.now().millisecondsSinceEpoch.toString(); // Generate unique ID
      final Task newTask = Task(
        categoryID: categoryController.text.trim(),
        dueTime: DateTime(
          selectedTime.hour,
          selectedTime.minute,
        ),
        taskID: id,
        title: taskTitleController.text.trim(),
        description: noteController.text.trim(),
        dueDate: DateTime(
          selectedTime.hour,
          selectedTime.minute,
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        ),
        status: categoryController.text.trim(),
      );
      await taskService.createTask(newTask);      //crud create
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task saved successfully!')),
      );
      Navigator.pop(context); // Close the page after saving
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save task: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.only(top: 30, left: 15),
                        decoration: BoxDecoration(
                          color: const Color(0Xff465A65),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 101,
                      height: 12,
                      color: const Color(0XffFCCA21),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Add Task',
                      style: TextStyle(
                        color: Color(0XffF273236),
                        fontFamily: "Poppins-Bold",
                        fontSize:38 ,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 101,
                      height: 12,
                      color: const Color(0XffFCCA21),
                    ),
                  ],
                ),
                const SizedBox(height: 55),
                Container(
                  height: 190,
                  width: 342,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0XffFCCA21),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: taskTitleController,
                        style: TextStyle(
                          color: Colors.black, // Change this to the desired text color
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 22,top: 14,bottom: 10 ,right: 22),
                            border: InputBorder.none,
                            hintText: "Task Title :",
                            hintStyle: TextStyle(
                              fontSize: 19,
                              color: Color(0xff606060),
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      Divider(
                        color: Colors.grey, // Color of the line
                        thickness: 1.0, // Thickness of the line
                        indent: 0, // Empty space to the leading edge
                        endIndent: 0, // Empty space to the trailing edge
                      ),
                      TextFormField(
                        controller: categoryController,
                        style: TextStyle(
                          color: Colors.black, // Change this to the desired text color
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 22,top: 10,bottom: 10 ,right: 22),
                            border: InputBorder.none,
                            hintText: "Category :",
                            hintStyle: TextStyle(
                              fontSize: 19,
                              color: Color(0xff606060),
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      Divider(
                        color: Colors.grey, // Color of the line
                        thickness: 1.0, // Thickness of the line
                        indent: 0, // Empty space to the leading edge
                        endIndent: 0, // Empty space to the trailing edge
                      ),
                      TextFormField(
                        controller: noteController,

                        style: TextStyle(
                          color: Colors.black, // Change this to the desired text color
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 22,top: 10,bottom: 10 ,right: 22),
                            border: InputBorder.none,
                            hintText: " Note : ",
                            hintStyle: TextStyle(
                              fontSize: 19,
                              color: Color(0xff606060),
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                    ],

                  ),
                ),
                const SizedBox(height: 100),
                Container(
                  height: 85,
                  width: 371,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0Xff465A65),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20), // مسافة جوا المربع
                      const Text(
                        'Time',
                        style: TextStyle(
                          fontFamily: "Poppins-SemiBold",
                          color: Colors.white,
                          fontSize: 27,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: _showTimePicker, // فتح الـ Time Picker
                        child: const Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: _showCupertinoDatePicker, // فتح الـ CupertinoDatePicker
                  child: Container(
                    height: 85,
                    width: 371,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0Xff465A65),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        const Text(
                          'Date',
                          style: TextStyle(
                            fontFamily: "Poppins-SemiBold",
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: _saveTask,
                  child: Container(
                    height: 63,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0XffFCCA21),
                    ),
                    child: const Center(
                      child: Text(
                        'Done!',
                        style: TextStyle(
                          fontFamily: "Poppins-SemiBold",
                          color: Color(0XffF273236),
                          fontSize: 27,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
