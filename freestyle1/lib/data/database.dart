import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  final _myBox = Hive.box("MyBox");

  List todolist = [];

  void createInitialData() {
    todolist = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  void loadData() {
    todolist = List.of(_myBox.get("TODOLIST"));
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", todolist);
  }
}
