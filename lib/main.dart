import 'package:flutter/material.dart';
import 'package:to_do_app/add_to_do_list.dart';
import 'login_page.dart';
import 'todo_list.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData.light(),
      home: const LoginPage(),
      routes: {
        'login': (context) => const LoginPage(),
        'todo_list': (context) => const TodoList(username: 'exampleUsername'),
        'add_to_do_list': (context) => const AddToDoList(),
      },
    );
  }
}

