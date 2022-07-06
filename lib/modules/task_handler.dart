import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/db/boxes.dart';
import 'package:todo_app/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskData extends ChangeNotifier {
  static List<Task> task = Boxes.getTasks().values.toList().cast<Task>();

  int get taskCount {
    return task.length;
  }

  static void refreshTasks() {
    task = Boxes.getTasks().values.toList().cast<Task>();
  }

  void addTask(String newTaskTitle) async {
    final newTask = Task()
      ..name = newTaskTitle
      ..isDone = false;
    final box = Boxes.getTasks();
    await box.add(newTask);
    notifyListeners();
  }

  void deleteTask(dynamic taskKey) async {
    await Boxes.getTasks().delete(taskKey);
    notifyListeners();
  }

  void updateTask(dynamic key, String title, bool done) async {
    await Boxes.getTasks().putAt(
        key,
        Task()
          ..name = title
          ..isDone = done ? false : true);
    notifyListeners();
  }

  void deleteAllTasks() async {
    List<dynamic> keyList = [];
    for (var task in task) {
      keyList.add(task.key);
    }
    await Boxes.getTasks().deleteAll(keyList);
  }
}
