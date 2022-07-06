import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/task_handler.dart';
import 'package:todo_app/widgets/task_tile.dart';
import 'package:todo_app/themes/app_color.dart';

class TasksList extends StatefulWidget {
  ScrollController? controller;

  TasksList({this.controller});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.separated(
          controller: widget.controller,
          separatorBuilder: (context, index) => const Divider(
            thickness: 0.2,
            height: 0,
            color: Colors.grey,
          ),
          padding:
              const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 65),
          itemBuilder: (context, index) {
            final task = TaskData.task[index];
            return TaskTile(
              taskKey: task.key,
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallback: (checkboxState) {
                taskData.updateTask(index, task.name, task.isDone);
                TaskData.refreshTasks();
              },
              longPressCallBack: () async => await showDialog<void>(
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
              ),
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
