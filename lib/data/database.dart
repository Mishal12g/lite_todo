import 'package:hive_flutter/hive_flutter.dart';
import 'package:lite_todo/models/task.dart';

final class ToDoDataBase {
  static const toDiListIdentifier = "TODOLIST";
  List<dynamic> toDoList = [];

  // reference our box
  final _myBox = Hive.box("myBox");

  void createInitialData() {
    toDoList = [
      Task(text: "Make tutorial"),
      Task(text: "Do Exercise"),
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get(ToDoDataBase.toDiListIdentifier);
  }

  //update the database
  void updateDateBase() {
    _myBox.put(ToDoDataBase.toDiListIdentifier, toDoList);
  }
}
