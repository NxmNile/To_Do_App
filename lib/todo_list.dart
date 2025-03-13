import 'package:flutter/material.dart';
import 'package:to_do_app/add_to_do_list.dart';
import 'login_page.dart';
class TodoList extends StatefulWidget {
  final String username;
  const TodoList({super.key, required this.username});
  @override
  State<StatefulWidget>createState(){
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List for ${widget.username}', style: TextStyle(color: Colors.white),),

        backgroundColor: Color(0xFF9C6CFE),
      ),
      body: Stack( // Use Stack to overlay widgets
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // You can add other content here
              ],
            ),
          ),
          Positioned(
            right: 20, // Distance from the left edge
            bottom: 20, // Distance from the bottom edge
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToDoList()),
                );
              },
              child: Icon(Icons.add, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9C6CFE),
                minimumSize: Size(50, 50),
                  shape: CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}