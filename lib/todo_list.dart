import 'package:flutter/material.dart';
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
        title:
        Text('Todo List for ${widget.username}', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF9C6CFE),
      ),
      body:

          todoListSection(),
      floatingActionButton: todoButtonSection(),

    );
  }
  Widget todoListSection(){
    Widget todoItem(int todoIndex) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5), // กำหนด margin
        padding: EdgeInsets.symmetric(horizontal: 10), // เพิ่ม padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), // มุมโค้ง
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: ListTile(
          title: Text(todoList[todoIndex]["content"]),
          trailing: IconButton(
            icon: Icon(todoList[todoIndex]["icon"]),
            onPressed: () {
              setState(() {
                if (todoList[todoIndex]["status"] == "undone") {
                  todoList[todoIndex]["status"] = "done";
                  todoList[todoIndex]["icon"] = iconItemDone;
                } else {
                  todoList[todoIndex]["status"] = "undone";
                  todoList[todoIndex]["icon"] = iconItemUndone;
                }
              });
            },
          ),
          onLongPress: () => _onItemLongPress(todoIndex),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 16), // Add space between the list and the AppBar
      child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return todoItem(index);
        },
      ),
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
  void _onItemLongPress(int todoIndex){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            height: 200,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(iconItemEdit),
                  title: Text('Edit'),
                  onTap: (){
                    Navigator.pop(context);
                    _editTask(todoIndex);
                  },
                ),
                ListTile(
                  leading: Icon(iconItemDelete),
                  title: Text('Delete'),
                  onTap: (){
                    Navigator.pop(context);
                    _deleteTask(todoIndex);
                  },
                ),
              ],
            ),
          );
        });
  }
  void _editTask(int todoIndex){
    TextEditingController taskController =
    TextEditingController(text: todoList[todoIndex]["content"]);
    void editSubmission(String value) {
      final bool isNotBlank = !RegExp(r"^\s*$").hasMatch(value);
      if (value.isNotEmpty && isNotBlank) {
        setState(() {
          todoList[todoIndex]["content"] = value.trim();
        });
        Future.delayed(Duration(milliseconds: 300), () {
          alert(context: context, title: "Success", message: "Task edited successfully");
        });
      } else {
        alert(context: context, title: "Error", message: "Task cannot be empty");
      }
    }
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Edit Task'),
            content: TextField(
          autofocus: true,
            controller: taskController,
          onSubmitted: (val)=> editSubmission(val),
          decoration: const InputDecoration(
          hintText: 'Edit your task ',
          contentPadding:  EdgeInsets.all(16.0),
          ),
          ),
          actions: [
            TextButton.icon(
              onPressed: (){
                editSubmission(taskController.text);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save_alt),
              label: const Text('Save'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            )
          ],
          );
        });
  }
  void _deleteTask(int todoIndex){
    setState(() {
      todoList.removeAt(todoIndex);
    });
  }
}