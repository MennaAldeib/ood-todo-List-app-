import 'package:flutter/material.dart';
import 'hometask.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: 430,
            height: 530,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/your tasks.jpg'), // Ensure this path is correct
              ),
            ),
          ),
          //SizedBox(height: 10),
          Container(
            height: 90,
            width: 330,
            decoration: BoxDecoration(
              color: Color(0xFFFFCA21), // Correct color
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Welcome Jehan',
                style: TextStyle(
                  fontFamily: "Poppins-SemiBold",
                  color: Color(0xFF465A65), // Correct color
                  fontSize: 27,
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyTasks()), // Ensure MyTasks exists
              );
            },
            child: Container(
              height: 86,
              width: 250,
              decoration: BoxDecoration(
                color: Color(0xFFFFCA21), // Correct color
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  ' Your Tasks',
                  style: TextStyle(
                    fontFamily: "Poppins-SemiBold",
                    color: Color(0xFF465A65), // Correct color
                    fontSize: 27,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
