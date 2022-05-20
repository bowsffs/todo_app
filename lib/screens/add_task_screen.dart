import 'package:flutter/material.dart';
import 'package:todo_app/themes/app_color.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_data.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle = '';

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'فعالیت جدید',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.currentAppColor,
              fontSize: 30.0,
            ),
          ),
          TextField(
              textAlign: TextAlign.center,
              cursorColor: AppColor.currentAppColor,
              autofocus: true,
              onChanged: (str) {
                newTaskTitle = str;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.currentAppColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.currentAppColor),
                ),
              )),
          TextButton(
            child: const Text(
              'افزودن',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColor.currentAppColor),
            ),
            onPressed: () {
              if (newTaskTitle.trim().isNotEmpty) {
                Provider.of<TaskData>(context, listen: false)
                    .addTask(newTaskTitle);
                TaskData.refreshTasks();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
