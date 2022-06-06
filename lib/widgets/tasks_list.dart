import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/task_handler.dart';
import 'package:todo_app/widgets/task_tile.dart';

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
        return ListView.builder(
          controller: widget.controller,
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
              longPressCallBack: () {
                setState(() {
                  taskData.deleteTask(task.key);
                  TaskData.refreshTasks();
                });
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
