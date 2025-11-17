import 'package:flutter/material.dart';
import 'package:freestyle1/data/database.dart';
import 'package:freestyle1/utilities/dialog_box.dart';
import 'package:freestyle1/utilities/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box("MyBox");

  final _controller = TextEditingController();
  final db = ToDoDataBase();

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
      db.updateDataBase();
    } else {
      db.loadData();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = value ?? false;
    });
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void saveNewTask() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      db.todolist.add([text, false]);
    });
    _controller.clear();
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.todolist.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        elevation: 2,
        title: Center(
          child: Title(color: Colors.black, child: Text("ToDoApp")),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.yellow[200],
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todolist.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todolist[index][0],
            taskCompleted: db.todolist[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
