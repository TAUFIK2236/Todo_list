import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/Pages/HomePage.dart';
import 'package:todo_app/Pages/Logn_in_page.dart';
import 'package:todo_app/Pages/Todo_create_page.dart';

import 'api/apiService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:  LoginPage(),
        );
      },
    );
  }
}



