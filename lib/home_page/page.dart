import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lite_todo/data/database.dart';
import 'package:lite_todo/models/task.dart';
import 'package:lite_todo/ui/dialog_box.dart';
import 'package:lite_todo/ui/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// reference the hive box
  final _myBox = Hive.box("myBox");
  final db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get(ToDoDataBase.toDiListIdentifier) == null) {
      db.createInitialData();
      db.updateDateBase();
    } else {
      db.loadData();
    }

    super.initState();
  }

// text controller
  final _controller = TextEditingController();

// checkBox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index].isCompleted = !db.toDoList[index].isCompleted;
    });
    db.updateDateBase();
  }

// create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: _controller,
        onCancel: () => Navigator.of(context).pop(),
        onSave: saveNewTask,
      ),
    );
  }

  // save new task
  void saveNewTask() {
    if (_controller.text.isNotEmpty && !_controller.text.startsWith(" ")) {
      setState(
        () {
          db.toDoList.add(
            Task(text: _controller.text),
          );
          Navigator.of(context).pop();
          _controller.clear();
        },
      );
      db.updateDateBase();
    }
  }

// delete task
  void deleteTack(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDateBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade100,
        onPressed: createNewTask,
        child: const Icon(
          Icons.add,
          color: Colors.deepPurple,
        ),
      ),
      appBar: AppBar(
        title: const Text("Todo Lite"),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index].text,
            taskCompleted: db.toDoList[index].isCompleted,
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTack(index),
          );
        },
      ),
    );
  }
}
