import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/db/boxes.dart';
import 'package:todo_app/models/task.dart';

class TaskData extends ChangeNotifier {
  static List<Task> task = Boxes.getTasks().values.toList().cast<Task>();

  int get taskCount {
    return task.length;
  }

  List get tasks {
    return Boxes.getTasks().values.toList().cast<Task>();
  }

  Task getTaskByKey(key) {
    var task = Boxes.getTasks().get(key);
    if (task != null) {
      return task;
    }
    return Task();
  }

  static void refreshTasks() {
    task = Boxes.getTasks().values.toList().cast<Task>();
  }

  void addTask(String newTaskTitle, DateTime now) async {
    final newTask = Task()
      ..name = newTaskTitle
      ..initDate = now;
    final box = Boxes.getTasks();
    await box.add(newTask);
    notifyListeners();
  }

  void deleteTask(dynamic taskKey) async {
    await Boxes.getTasks().delete(taskKey);
    notifyListeners();
  }

  void updateTask(
      int index,
      String newName,
      List<String> newSubtasks,
      DateTime? newAlarmNotificationDate,
      Map<String, bool> newOptions,
      DateTime initDate,
      String? newNotificationSound) async {
    await Boxes.getTasks().putAt(
        index,
        Task()
          ..name = newName
          ..subTasks = newSubtasks
          ..notificationAndAlarmDate = newAlarmNotificationDate
          ..options = newOptions
          ..initDate = initDate
          ..notificationSound = newNotificationSound ?? 'sound1');
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
