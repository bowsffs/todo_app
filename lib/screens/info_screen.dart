import 'dart:typed_data';
import 'package:todo_app/modules/events.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/app_color.dart' as theme;
import 'package:todo_app/modules/task_handler.dart';
import 'package:todo_app/modules/notification_api.dart';
import 'package:todo_app/widgets/date_picker.dart';
import 'add_task_screen.dart';
import 'package:todo_app/widgets/custom_card.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/circle_button.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class InfoScreen extends StatefulWidget with DatePickerFa {
  InfoScreen({Key? key, required this.taskKey, required this.taskIndex})
      : super(key: key);

  final dynamic taskKey;
  final int taskIndex;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Task currentTask;

  late int taskIndex;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    NotificationApi.init();
    listenNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentTask = TaskData.task.elementAt(widget.taskIndex);
    taskIndex = widget.taskIndex;
    return Scaffold(
      body: Theme(
        data: ThemeData(
          fontFamily: 'Dirooz',
          primaryColor: theme.AppColor.currentAppColor,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: theme.AppColor.currentAppColor,
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: theme.AppColor.currentAppColor,
                expandedHeight: MediaQuery.of(context).size.height / 3.7,
                leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_outlined)),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.drive_file_rename_outline_rounded),
                    onPressed: () async => _showEditTaskScreen(context),
                  ),
                  const SizedBox(
                    width: 7,
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/pic1.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showAddSubTaskScreen(BuildContext context, int index) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddTaskScreen(
          label: 'فعالیت مرتبط',
          buttonText: 'افزودن',
          taskKey: widget.taskKey,
          afterTextValidationCallback: (value, key) {
            var newSubTasks = currentTask.subTasks;
            newSubTasks.add(value);
            Provider.of<TaskData>(context, listen: false).updateTask(
                taskIndex,
                currentTask.name,
                newSubTasks,
                currentTask.notificationAndAlarmDate,
                currentTask.options,
                currentTask.initDate,
                currentTask.notificationSound);
            TaskData.refreshTasks();
            Navigator.pop(context);
          },
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Widget buildContent() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomCard(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: theme.AppColor.currentAppColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('فعالیت :'),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(currentTask.name),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: theme.AppColor.currentAppColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('تاریخ ساخت :'),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(currentTask.initDate.toPersianDate()),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.list,
                      color: theme.AppColor.currentAppColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('فعالیت های مرتبط :'),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: ListView.separated(
                    controller: _controller,
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1,
                      height: 0,
                      color: theme.AppColor.currentAppColor.withOpacity(0.3),
                    ),
                    itemCount: currentTask.subTasks.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: ListTile(
                          style: ListTileStyle.drawer,
                          title: Text(
                            currentTask.subTasks[index],
                          ),
                        ),
                        onLongPress: () {
                          var newSubTasks = currentTask.subTasks;
                          newSubTasks.removeAt(index);
                          int currentMainTaskIndex =
                              TaskData.task.indexOf(currentTask);

                          setState(
                            () {
                              Provider.of<TaskData>(context, listen: false)
                                  .updateTask(
                                currentMainTaskIndex,
                                currentTask.name,
                                newSubTasks,
                                currentTask.notificationAndAlarmDate,
                                currentTask.options,
                                currentTask.initDate,
                                currentTask.notificationSound,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleButton(
                      circleButtonFunc: () async {
                        await _showAddSubTaskScreen(context, taskIndex);
                        _controller.animateTo(
                          _controller.position.maxScrollExtent + 200,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      circleIcon: Icons.add,
                      iconWidth: 40,
                      iconHeight: 40,
                      iconSize: 20,
                      backgroundColor: theme.AppColor.currentAppColor,
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      color: theme.AppColor.currentAppColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('تاریخ و آلارم :'),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      theme.AppColor.currentAppColor.withOpacity(0.1),
                    ),
                  ),
                  onPressed: _showDateTimePicker,
                  child: Text(
                    'تاریخ و ساعت',
                    style: TextStyle(
                      color: currentTask.notificationAndAlarmDate == null
                          ? Colors.grey
                          : theme.AppColor.currentAppColor,
                    ),
                  ),
                ),
                if (currentTask.notificationAndAlarmDate != null)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    child: Text(
                      '${currentTask.notificationAndAlarmDate!.toJalali().formatFullDate()} , ${currentTask.notificationAndAlarmDate!.hour}:${currentTask.notificationAndAlarmDate!.minute}'
                          .toPersianDigit(),
                      style: TextStyle(color: theme.AppColor.currentAppColor),
                    ),
                  ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('آلارم'),
                    Switch(
                      activeColor: theme.AppColor.currentAppColor,
                      value: Provider.of<TaskData>(context, listen: true)
                          .tasks[taskIndex]
                          .options['notification']!,
                      onChanged: currentTask.notificationAndAlarmDate != null
                          ? (value) {
                              _toggleSwitch(value, 'notification');
                            }
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 7.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('تکرار'),
                    Switch(
                      activeColor: theme.AppColor.currentAppColor,
                      value: Provider.of<TaskData>(context, listen: true)
                          .tasks[taskIndex]
                          .options['iteration']!,
                      onChanged: currentTask.notificationAndAlarmDate != null &&
                              currentTask.options['notification'] == true
                          ? (value) {
                              _toggleSwitch(value, 'iteration');
                            }
                          : null,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7.5,
                ),
                SizedBox(
                  height: 47,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('صدای آلارم'),
                      _buildSoundDropDown(
                        Provider.of<TaskData>(context, listen: true)
                            .tasks[taskIndex]
                            .notificationSound,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          CustomCard(
              child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.event_outlined,
                    color: theme.AppColor.currentAppColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('مناسبت های روز انتخاب شده :'),
                ],
              ),
              if (Provider.of<TaskData>(context, listen: true)
                      .tasks[taskIndex]
                      .notificationAndAlarmDate !=
                  null)
                _buildEventList(),
            ],
          )),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Widget _buildEventList() {
    List<Map<String, Object>> eventsList = [];
    var notificationDate = Provider.of<TaskData>(context, listen: true)
        .tasks[taskIndex]
        .notificationAndAlarmDate!;
    if (currentTask.notificationAndAlarmDate != null) {
      var nullableListOfEvents = EventApi.getEventsByDateTime(notificationDate);
      if (nullableListOfEvents.isNotEmpty) {
        eventsList = nullableListOfEvents;
      }
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4.5,
      width: MediaQuery.of(context).size.width / 0.75,
      child: ListView.builder(
        itemCount: eventsList.length,
        itemBuilder: (context, index) {
          var event = eventsList[index]["Title"];
          return ListTile(
            style: ListTileStyle.drawer,
            title: Text(
              event.toString(),
              style: TextStyle(
                  color: eventsList[index]['IsVacation'] == true
                      ? theme.AppColor.currentAppColor
                      : Colors.black87),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSoundDropDown(dynamic userValue) {
    List<int> listItems = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
    ];

    dynamic vvalue = userValue;

    return Container(
      height: 30,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: theme.AppColor.currentAppColor.withAlpha(180), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          borderRadius: BorderRadius.circular(10),
          iconSize: 0.0,
          menuMaxHeight: MediaQuery.of(context).size.height / 5,
          items: listItems
              .map(
                (e) => DropdownMenuItem(
                  alignment: AlignmentDirectional.centerEnd,
                  value: 'sound$e',
                  child: Text(
                    'افکت $e'.toPersianDigit(),
                    style: const TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                ),
              )
              .toList(),
          value: vvalue,
          onChanged: currentTask.notificationAndAlarmDate != null &&
                  currentTask.options['notification'] == true
              ? (value) async {
                  setState(
                    () {
                      vvalue = value;
                      Provider.of<TaskData>(context, listen: false).updateTask(
                        taskIndex,
                        currentTask.name,
                        currentTask.subTasks,
                        currentTask.notificationAndAlarmDate,
                        currentTask.options,
                        currentTask.initDate,
                        vvalue,
                      );
                    },
                  );
                  try {
                    await NotificationApi.showScheduledNotification(
                        repeatFlagFour: currentTask.options['iteration'] == true
                            ? Int32List.fromList(<int>[4])
                            : null,
                        scheduledDate: currentTask.notificationAndAlarmDate!,
                        notificationSound: vvalue,
                        id: taskIndex,
                        title: 'فعالیت خود را چک کنید',
                        body: currentTask.name.length > 15
                            ? currentTask.name.substring(0, 15) + '...'
                            : currentTask.name,
                        payload: 'task payload');
                  } catch (e) {
                    var newOptions = currentTask.options;
                    newOptions['notification'] = false;
                    Provider.of<TaskData>(context, listen: false).updateTask(
                        taskIndex,
                        currentTask.name,
                        currentTask.subTasks,
                        currentTask.notificationAndAlarmDate,
                        newOptions,
                        currentTask.initDate,
                        currentTask.notificationSound);
                  }
                }
              : null,
        ),
      ),
    );
  }

  void _showDateTimePicker() async {
    DateTime? userSelectedDateTime = await DatePickerFa.getUserSelectedDateTime(
        context, theme.AppColor.currentAppColor);
    if (userSelectedDateTime != null) {
      setState(() {
        var newOptions = currentTask.options;
        newOptions['notification'] = true;
        Provider.of<TaskData>(context, listen: false).updateTask(
            taskIndex,
            currentTask.name,
            currentTask.subTasks,
            userSelectedDateTime,
            newOptions,
            currentTask.initDate,
            currentTask.notificationSound);
        TaskData.refreshTasks();
      });

      try {
        await NotificationApi.showScheduledNotification(
            repeatFlagFour: currentTask.options['iteration'] == true
                ? Int32List.fromList(<int>[4])
                : null,
            scheduledDate: userSelectedDateTime,
            id: taskIndex,
            title: 'فعالیت خود را چک کنید',
            body: currentTask.name.length > 15
                ? currentTask.name.substring(0, 15) + '...'
                : currentTask.name,
            payload: 'task payload');
      } catch (e) {
        var newOptions = currentTask.options;
        newOptions['notification'] = false;
        Provider.of<TaskData>(context, listen: false).updateTask(
            taskIndex,
            currentTask.name,
            currentTask.subTasks,
            currentTask.notificationAndAlarmDate,
            newOptions,
            currentTask.initDate,
            currentTask.notificationSound);
      }
    }
  }

  void _toggleSwitch(bool value, String option) async {
    try {
      Map<String, bool> newOptions = currentTask.options;
      newOptions[option] = value;
      setState(() {
        Provider.of<TaskData>(context, listen: false).updateTask(
            taskIndex,
            currentTask.name,
            currentTask.subTasks,
            currentTask.notificationAndAlarmDate,
            newOptions,
            currentTask.initDate,
            currentTask.notificationSound);
      });
      if (value == true) {
        await NotificationApi.showScheduledNotification(
            scheduledDate: currentTask.notificationAndAlarmDate!,
            notificationSound: currentTask.notificationSound,
            repeatFlagFour: currentTask.options['iteration'] == true
                ? Int32List.fromList(<int>[4])
                : null,
            id: taskIndex,
            title: 'فعالیت خود را چک کنید',
            body: currentTask.name.length > 15
                ? currentTask.name.substring(0, 15) + '...'
                : currentTask.name,
            payload: 'task payload');
      } else {
        if (option == 'notification') {
          NotificationApi.notifications.cancel(taskIndex);
        } else if (option == 'iteration') {
          await NotificationApi.showScheduledNotification(
              repeatFlagFour: null,
              scheduledDate: currentTask.notificationAndAlarmDate!,
              notificationSound: currentTask.notificationSound,
              id: taskIndex,
              title: 'فعالیت خود را چک کنید',
              body: currentTask.name.length > 15
                  ? currentTask.name.substring(0, 15) + '...'
                  : currentTask.name,
              payload: 'task payload');
        }
      }
    } catch (e) {
      var newOptions = currentTask.options;
      newOptions[option] = false;
      Provider.of<TaskData>(context, listen: false).updateTask(
          taskIndex,
          currentTask.name,
          currentTask.subTasks,
          currentTask.notificationAndAlarmDate,
          newOptions,
          currentTask.initDate,
          currentTask.notificationSound);
    }
  }

  Future<void> _showEditTaskScreen(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddTaskScreen(
          label: 'فعالیت',
          buttonText: 'تغییر',
          text: currentTask.name,
          taskKey: widget.taskKey,
          afterTextValidationCallback: (value, key) {
            Provider.of<TaskData>(context, listen: false).updateTask(
                taskIndex,
                value,
                currentTask.subTasks,
                currentTask.notificationAndAlarmDate,
                currentTask.options,
                currentTask.initDate,
                currentTask.notificationSound);
            TaskData.refreshTasks();
            Navigator.pop(context);
          },
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InfoScreen(
          taskIndex: taskIndex,
          taskKey: widget.taskKey,
        ),
      ),
    );
  }
}
