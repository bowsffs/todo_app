import 'package:flutter/material.dart';
import 'package:todo_app/themes/app_color.dart';
import 'package:todo_app/db/boxes.dart';
import 'package:todo_app/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/themes/app_color.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = '';

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              int sensitivity = 8;
              if (details.delta.dy > sensitivity) {
                // Down Swipe
              } else if (details.delta.dy < -sensitivity) {
                // Up Swipe
              }
            });
          },
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
                child: Text(
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
        ),
      ),
    );
  }
}
