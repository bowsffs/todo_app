import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:todo_app/models/color.dart';
import 'package:todo_app/models/state.dart';
import 'package:todo_app/widgets/tasks_list.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/modules/app_color.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/task_handler.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/db/boxes.dart';
import 'package:todo_app/widgets/circle_button.dart';
import 'package:todo_app/screens/pick_color_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: AppColor.currentAppColor,
      floatingActionButton: FloatingActionButton(
        elevation: 5.0,
        onPressed: () async {
          await _showAddScreen(context);
        },
        backgroundColor: AppColor.currentAppColor,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 5.0, left: 30.0, bottom: 20.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'روزانه',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black12,
                        ),
                      ],
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.rtl,
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          CircleButton(
                            circleIcon: Icons.arrow_downward_outlined,
                            circleButtonFunc: _scrollDown,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          CircleButton(
                            circleIcon: Icons.arrow_upward_outlined,
                            circleButtonFunc: _scrollUp,
                          ),
                        ],
                      ),
                      Text(
                        '${Provider.of<TaskData>(context, listen: true).taskCount}'
                                .toPersianDigit() +
                            ' فعالیت',
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black12,
                            ),
                          ],
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      Row(
                        children: [
                          CircleButton(
                            circleIcon: Icons.brush_outlined,
                            circleButtonFunc: _pickColorDialog,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          CircleButton(
                            circleIcon: Icons.delete,
                            circleButtonFunc: _deleteDialog,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, -1), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: Container(
                    child: TasksList(controller: _controller),
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showAddScreen(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AddTaskScreen(
        taskKey: null,
        label: 'فعالیت جدید',
        buttonText: 'افزودن',
        afterTextValidationCallback: (value, _) {
          Provider.of<TaskData>(context, listen: false)
              .addTask(value, DateTime.now());
          TaskData.refreshTasks();

          Navigator.pop(context, true);
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  void _firstTimeRun() {
    late List<StateRoozane> state;
    if (Boxes.getState().isEmpty) {
      Boxes.getState().add(StateRoozane()..appFirstTimeRun = false);
      state = Boxes.getState().values.toList().cast<StateRoozane>();
    } else {
      state = Boxes.getState().values.toList().cast<StateRoozane>();
    }

    if (!state[0].appFirstTimeRun) {
      Boxes.getColor()
          .add(ColorSchemeRoozane()..hex = AppColor.allPrimaryColors[1]);
      Boxes.getState()
          .putAt(state[0].key, StateRoozane()..appFirstTimeRun = true);
    }
  }

  Future<int?> _pickColorDialog() async => await showDialog<int?>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              content: const PickColorScreen(),
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
              ],
            ),
          );
        },
      ).then((value) {
        if (value != null) {
          setState(() {
            AppColor.changeAppColor(value);
          });
        }
        return null;
      });

  Future<void> _deleteDialog() async => await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              content: const Text("آیا تمام فعالیت ها حذف شوند؟"),
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
                      TaskData().deleteAllTasks();
                      TaskData.refreshTasks();
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ),
          );
        },
      );

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void initState() {
    _firstTimeRun();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }
}
