import 'package:flutter/material.dart';
import 'package:todo_app/models/color.dart';
import 'package:todo_app/models/state.dart';
import 'package:todo_app/widgets/tasks_list.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/themes/app_color.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_data.dart';
import 'package:hive/hive.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:todo_app/db/boxes.dart';

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
      Boxes.getColor().add(ColorSchemeRoozane()
        ..hex = 0xFF009688
        ..index = 5);
      Boxes.getState()
          .putAt(state[0].key, StateRoozane()..appFirstTimeRun = true);
    }

    super.initState();
  }

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  String getTaskCountString(int num) {
    return num == 0 ? 'شما فعالیتی ندارید!' : '$num فعالیت';
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
            builder: (context) => AddTaskScreen(),
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
                top: 60.0, left: 30.0, bottom: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                SwipeTo(
                  iconColor: Colors.white,
                  iconOnLeftSwipe: const IconData(5),
                  iconOnRightSwipe: const IconData(5),
                  animationDuration: const Duration(milliseconds: 230),
                  onRightSwipe: () {
                    setState(() {
                      AppColor.previousColor();
                    });
                  },
                  onLeftSwipe: () {
                    setState(() {
                      AppColor.nextColor();
                    });
                  },
                  child: const Text(
                    'روزانه',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  getTaskCountString(Provider.of<TaskData>(context).taskCount),
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
                  textDirection: TextDirection.rtl,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _scrollUp();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_downward,
                            size: 20.0,
                            color: AppColor.currentAppColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _scrollDown();
                        });
                      },
                      child: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_upward,
                          size: 20.0,
                          color: AppColor.currentAppColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
}
