import 'package:flutter/material.dart';
import 'package:todo_app/themes/app_color.dart';

class TaskTile extends StatelessWidget {
  bool? isChecked = false;
  final String taskTitle;
  final Function(bool?)? checkboxCallback;
  final Function()? longPressCallBack;

  TaskTile(
      {this.isChecked,
      required this.taskTitle,
      this.checkboxCallback,
      this.longPressCallBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
      child: ListTile(
        onLongPress: longPressCallBack,
        title: Text(
          taskTitle,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              decoration:
                  isChecked ?? false ? TextDecoration.lineThrough : null),
        ),
        leading: Checkbox(
          activeColor: AppColor.currentAppColor,
          value: isChecked,
          onChanged: checkboxCallback,
        ),
      ),
    );
  }
}
