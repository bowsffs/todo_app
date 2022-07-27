import 'package:flutter/material.dart';
import 'package:todo_app/modules/app_color.dart';
import 'package:todo_app/screens/info_screen.dart';
import 'package:todo_app/models/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final dynamic taskKey;
  final bool isChecked;
  final bool isStarred;
  final String taskTitle;
  final void Function(bool?) tikCheckboxCallback;
  final void Function() starCheckboxCallback;
  final Function() longPressCallBack;
  final int taskIndex;

  const TaskTile(
      {this.taskKey,
      required this.task,
      required this.taskIndex,
      required this.isChecked,
      required this.isStarred,
      Key? key,
      required this.taskTitle,
      required this.starCheckboxCallback,
      required this.tikCheckboxCallback,
      required this.longPressCallBack})
      : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2, left: 7, right: 7),
          child: Theme(
            data: ThemeData(
                splashColor: AppColor.currentAppColor.withOpacity(0.5),
                fontFamily: 'Dirooz'),
            child: Card(
              shadowColor: AppColor.currentAppColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                style: ListTileStyle.drawer,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.2, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                textColor:
                    widget.isChecked ? const Color(0xff9e978e) : Colors.black87,
                tileColor: Colors.white,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoScreen(
                      taskIndex: widget.taskIndex,
                      taskKey: widget.taskKey,
                    ),
                  ),
                ),
                onLongPress: widget.longPressCallBack,
                title: Text(
                  widget.taskTitle,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    decoration:
                        widget.isChecked ? TextDecoration.lineThrough : null,
                  ),
                ),
                leading: SizedBox(
                  width: 72.0,
                  child: Row(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: widget.starCheckboxCallback,
                            child: Icon(
                              widget.isStarred
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              color: widget.isStarred
                                  ? AppColor.currentAppColor
                                  : const Color(0xff606060),
                            ),
                          ),
                        ),
                      ),
                      Checkbox(
                        activeColor: AppColor.currentAppColor,
                        value: widget.isChecked,
                        onChanged: widget.tikCheckboxCallback,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFF757575)),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
