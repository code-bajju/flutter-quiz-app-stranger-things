import 'package:flutter/material.dart';
import 'package:quiz/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz  App',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: Home(),
    );
  }
}