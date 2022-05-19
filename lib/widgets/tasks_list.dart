import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TasksList extends StatefulWidget {
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return ListView.builder(
        padding: EdgeInsets.only(bottom: kFloatingActionButtonMargin + 50),
        itemBuilder: (context, index) {
          final task = TaskData.task[index];
          return TaskTile(
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
    });
  }
}
