import 'package:flutter/material.dart';
import 'package:todo/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "todo",
      home: Mainscreen(),
      theme: ThemeData.light(
        useMaterial3: true,
      ),
    );
  }
}
