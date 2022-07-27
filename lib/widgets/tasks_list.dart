import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/modules/task_handler.dart';
import 'package:todo_app/widgets/task_tile.dart';
import 'package:todo_app/modules/app_color.dart';

class TasksList extends StatefulWidget {
  final ScrollController? controller;

  const TasksList({Key? key, this.controller}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: ListView.builder(
            shrinkWrap: true,
            controller: widget.controller,
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 7),
            itemCount: taskData.taskCount,
            itemBuilder: (context, index) {
              final task = TaskData.task[index];
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TaskTile(
                    task: task,
                    taskIndex: index,
                    taskKey: task.key,
                    isStarred: task.options['isStarred']!,
                    taskTitle: task.name,
                    isChecked: task.options['isDone']!,
                    tikCheckboxCallback: (value) {
                      Map<String, bool> newwOptions = task.options;
                      newwOptions["isDone"] = value!;
                      taskData.updateTask(
                          index,
                          task.name,
                          task.subTasks,
                          task.notificationAndAlarmDate,
                          newwOptions,
                          task.initDate,
                          task.notificationSound);
                      TaskData.refreshTasks();
                    },
                    starCheckboxCallback: () {
                      bool newStarValue = !task.options["isStarred"]!;
                      Map<String, bool> newOptions = task.options;
                      newOptions["isStarred"] = newStarValue;
                      taskData.updateTask(
                          index,
                          task.name,
                          task.subTasks,
                          task.notificationAndAlarmDate,
                          newOptions,
                          task.initDate,
                          task.notificationSound);
                      TaskData.refreshTasks();
                    },
                    longPressCallBack: () async =>
                        await _deletePopUp(context, taskData, task),
                  ),
                );
              }
              return TaskTile(
                task: task,
                taskIndex: index,
                taskKey: task.key,
                isStarred: task.options['isStarred']!,
                taskTitle: task.name,
                isChecked: task.options['isDone']!,
                tikCheckboxCallback: (value) {
                  Map<String, bool> newwOptions = task.options;
                  newwOptions["isDone"] = value!;
                  taskData.updateTask(
                      index,
                      task.name,
                      task.subTasks,
                      task.notificationAndAlarmDate,
                      newwOptions,
                      task.initDate,
                      task.notificationSound);
                  TaskData.refreshTasks();
                },
                starCheckboxCallback: () {
                  bool newStarValue = !task.options["isStarred"]!;
                  Map<String, bool> newOptions = task.options;
                  newOptions["isStarred"] = newStarValue;
                  taskData.updateTask(
                      index,
                      task.name,
                      task.subTasks,
                      task.notificationAndAlarmDate,
                      newOptions,
                      task.initDate,
                      task.notificationSound);
                  TaskData.refreshTasks();
                },
                longPressCallBack: () async =>
                    await _deletePopUp(context, taskData, task),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _deletePopUp(
      BuildContext context, TaskData taskData, Task task) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: const Text("آیا فعالیت حذف شود؟"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'لغو',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'حذف',
                  style: TextStyle(color: AppColor.currentAppColor),
                ),
                onPressed: () {
                  setState(() {
                    taskData.deleteTask(task.key);
                    TaskData.refreshTasks();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
