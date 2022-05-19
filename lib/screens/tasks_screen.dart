import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_app/widgets/tasks_list.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/themes/app_color.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:hive/hive.dart';

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: AppColor.currentAppColor,
      floatingActionButton: FloatingActionButton(
        elevation: 5.0,
        onPressed: () async {
          await showModalBottomSheet(
              context: context, builder: (context) => AddTaskScreen());
        },
        backgroundColor: AppColor.currentAppColor,
        child: Icon(
          Icons.add,
        ),
      ),
      body: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 60.0, left: 30.0, bottom: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.list,
                      size: 30.0,
                      color: AppColor.currentAppColor,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'روزانه',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${Provider.of<TaskData>(context).taskCount} فعالیت',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: TasksList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
