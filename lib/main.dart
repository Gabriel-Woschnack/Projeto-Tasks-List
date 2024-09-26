import 'package:flutter/material.dart';
import 'package:task_list/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
