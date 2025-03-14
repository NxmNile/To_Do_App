import 'package:flutter/material.dart';
import 'package:to_do_app/add_to_do_list.dart';
import 'login_page.dart';
import 'tools.dart';
class TodoList extends StatefulWidget {
  final String username;
  const TodoList({super.key, required this.username});
  @override
  State<StatefulWidget>createState(){
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  static const IconData iconItemUndone = Icons.check_box_outline_blank_rounded;
  static const IconData iconItemDone = Icons.check_box_rounded;
  static const IconData iconItemDelete = Icons.delete_outline_rounded;
  static const IconData iconItemEdit = Icons.edit;
  bool isAddButtonSelcted = false;
  List<Map<String, dynamic>> todoList = [
    {
      //mock up data1
      "content": "Example task 1",
      "status": "undone",
      "icon": iconItemUndone,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List for ${widget.username}', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF9C6CFE),
      ),
      body: todoListSection(),  // Use Stack to overlay widgets
      floatingActionButton: todoButtonSection(),

    );
  }
  Widget todoListSection(){
    Widget todoItem(int todoIndex){
      return ListTile(
        title: Text(todoList[todoIndex]["content"]),
        trailing: IconButton(
          icon: Icon(todoList[todoIndex]["icon"]),
          onPressed: (){
            setState(() {
              if(todoList[todoIndex]["status"] == "undone"){
                todoList[todoIndex]["status"] = "done";
                todoList[todoIndex]["icon"] = iconItemDone;
              }
              else{
                todoList[todoIndex]["status"] = "undone";
                todoList[todoIndex]["icon"] = iconItemUndone;
              }
            });
          },
        ),
      );
    }
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        return todoItem(index);
      },
    );
  }
  Widget todoButtonSection(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isAddButtonSelcted
                  ? FloatingActionButton.extended(
                    label: const Text('Add Task'),
                    icon: const Icon(Icons.add),
                    tooltip: "Add task",
                    heroTag: "addToDo",
                    onPressed: _addToDo,
                    backgroundColor: Color(0xFF9C6CFE),)
                  : FloatingActionButton(
                    tooltip: "Add task",
                    heroTag: "addToDo",
                    child:  Icon(Icons.add, color: Colors.white),
                    onPressed: _addToDo,
                    backgroundColor: Color(0xFF9C6CFE),
                    shape: CircleBorder(),
              )
            ],
      ),
    );

  }
  void _addToDo() async{
    TextEditingController taskController = TextEditingController();
    void addSubmission(String value) {
      final bool isNotBlank = !RegExp(r"^\s*$").hasMatch(value);
      if (value.isNotEmpty && isNotBlank) {
        setState(() {
          todoList.add({"content": value.trim(), "status": "undone", "icon": iconItemUndone});
        });
        Future.delayed(Duration(milliseconds: 300), () {
          alert(context: context, title: "Success", message: "Task added successfully");
        });

      } else {
        alert(context: context, title: "Error", message: "Task cannot be empty");
      }
    }
    setState(() {
      Icon : Icons.circle;
      isAddButtonSelcted = true;
      debugPrint("Add todo task");
      showDialog(context: context,
          builder: (BuildContext context){
        return AlertDialog(
          title: const Text('New Task'),
          content: TextField(
            autofocus: true,
            controller: taskController,
              onSubmitted: (val){addSubmission(val);},
            decoration: const InputDecoration(
              hintText: 'Enter your task to do...',
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
          actions: [
            TextButton.icon(onPressed: (){
              addSubmission(taskController.text);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.add_circle_rounded),
            label: const Text('Add Task'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            )
          ],
        );
          }).then((value) => setState(() {;
            Icon : Icons.add_circle_rounded;
            isAddButtonSelcted = false;
          }));
    });
  }
}