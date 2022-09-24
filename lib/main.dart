import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/layout/home_layout.dart';
import 'package:todo_project/layout/home_test.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeTest(),
    );
  }
}