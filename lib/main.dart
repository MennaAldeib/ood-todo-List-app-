import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'splash.dart';
import 'hivetask.dart';
import 'hiveuser.dart';
import 'hivecategory.dart';

import 'package:path_provider/path_provider.dart';


void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CategoryAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Hive CRUD Example',
      home: SplashScreen(),
    );
  }
}