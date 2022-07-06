import 'package:flutter/material.dart';
import 'package:todo_app/models/color.dart';
import 'package:todo_app/models/state.dart';
import 'package:todo_app/modules/notification_handler.dart';
import 'package:todo_app/widgets/tasks_list.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/themes/app_color.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/task_handler.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/db/boxes.dart';
import 'package:todo_app/widgets/circle_button.dart';
import 'package:todo_app/screens/pick_color_screen.dart';

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final ScrollController _controller = ScrollController();

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void initState() {
    _firstTimeRun();
    super.initState();
    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TasksScreen(),
      ),
    );
  }

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
            context: context,
            builder: (context) => const AddTaskScreen(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          );
        },
        backgroundColor: AppColor.currentAppColor,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 35.0, left: 30.0, bottom: 20.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'روزانه',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${Provider.of<TaskData>(context).taskCount} فعالیت',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
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
                          circleButtonFunc: () {
                            _scrollUp();
                          },
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        CircleButton(
                          circleIcon: Icons.arrow_upward_outlined,
                          circleButtonFunc: () {
                            _scrollDown();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleButton(
                          circleIcon: Icons.brush_outlined,
                          circleButtonFunc: () async {
                            await showModalBottomSheet(
                              context: context,
                              builder: (context) => const PickColorScreen(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  AppColor.changeAppColor(value);
                                });
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        CircleButton(
                          circleIcon: Icons.delete,
                          circleButtonFunc: () async => await showDialog<void>(
                            context: context,
                            barrierDismissible: true, // user must tap button!
                            builder: (BuildContext context) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: AlertDialog(
                                  content: const Text(
                                      "آیا تمام فعالیت ها حذف شوند؟"),
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
                                        style: TextStyle(
                                            color: AppColor.currentAppColor),
                                      ),
                                      onPressed:
                                          // () {
                                          //   setState(() {
                                          //     taskData.deleteTask(task.key);
                                          //     TaskData.refreshTasks();
                                          //   });
                                          () {
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
                          ),
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
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TasksList(controller: _controller),
            ),
          )
        ],
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
      Boxes.getTasks().add(Task()
        ..name =
            'با کشیدن اسم برنامه به سمت چپ و یا راست می توانید تم برنامه را تغییر دهید'
        ..isDone = false);
      Boxes.getTasks().add(Task()
        ..name = 'با استفاده از دکمه پلاس می توانید یک فعالیت جدید اضافه کنید'
        ..isDone = false);
      Boxes.getTasks().add(Task()
        ..name =
            'با نگه داشتن انگشت خود بر روی یک فعالیت می توانید آن را حذف کنید'
        ..isDone = false);
      Boxes.getTasks().add(Task()
        ..name = 'با دکمه های بالا و پایین به اول و آخر لیست طولانی خود بروید'
        ..isDone = false);
      Boxes.getTasks().add(Task()
        ..name =
            'وقتی فعالیت خود را انجام دادید تیک آن را بزنید تا آن فعالیت خط زده شود'
        ..isDone = false);
      Boxes.getTasks().add(Task()
        ..name =
            'برای فعال کردن اعلان فعالیت بر روی اعلان ضربه زده و تاریخ اعلان را مشخص نمایید'
        ..isDone = false);
      Boxes.getColor()
          .add(ColorSchemeRoozane()..hex = AppColor.allPrimaryColors[1]);
      Boxes.getState()
          .putAt(state[0].key, StateRoozane()..appFirstTimeRun = true);
    }
  }
}
