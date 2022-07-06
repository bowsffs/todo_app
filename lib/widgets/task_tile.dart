import 'package:flutter/material.dart';
import 'package:todo_app/modules/notification_handler.dart';
import 'package:todo_app/themes/app_color.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TaskTile extends StatelessWidget {
  final dynamic taskKey;
  bool? isChecked = false;
  final String taskTitle;
  final Function(bool?)? checkboxCallback;
  final Function()? longPressCallBack;

  TaskTile(
      {this.taskKey,
      this.isChecked,
      Key? key,
      required this.taskTitle,
      this.checkboxCallback,
      this.longPressCallBack})
      : super(key: key);

  DateTime? selectedDate;

  // Future<void> _selectDate(BuildContext context) async {
  // final TimeOfDay? picked = await showTimePicker(
  //   confirmText: 'تایید',
  //   cancelText: 'لغو',
  //   hourLabelText: 'ساعت',
  //   minuteLabelText: 'دقیقه',
  //   helpText: 'زمان آلارم',
  //   errorInvalidText: 'لطفا یک زمان صحیح وارد کنید',
  //   builder: (context, child) {
  //     return Theme(
  //       data: Theme.of(context).copyWith(
  //         colorScheme: ColorScheme.light(
  //           primary: AppColor.currentAppColor,
  //         ),
  //       ),
  //       child: Directionality(
  //         textDirection: TextDirection.rtl,
  //         child: child!,
  //       ),
  //     );
  //   },
  //   context: context,
  //   initialTime: TimeOfDay.now(),
  // );
  // if (picked != null) {
  //   // setState(() {
  //   selectedDate = picked;
  //   print('${selectedDate!.format(context)}');
  //   // });
  // }
  // }

  Future<void> _getUserSelectedDateTime(BuildContext context) async {
    DateTime? userSelectedDateTime =
        await DatePicker.showDateTimePicker(context,
            showTitleActions: true,
            theme: DatePickerTheme(
              // itemStyle:
              //     TextStyle(color: AppColor.currentAppColor, fontSize: 16),
              doneStyle: TextStyle(
                color: AppColor.currentAppColor,
                fontSize: 16,
              ),
            ),
            minTime: DateTime(DateTime.now().year, 1, 1),
            maxTime: DateTime(2050, 6, 7), onConfirm: (date) {
      NotificationApi.showScheduledNotification(
          id: taskKey,
          scheduledDate: date,
          title: 'لطفا فعالیت خود را چک کنید',
          body: taskTitle,
          payload: taskTitle);
    }, currentTime: DateTime.now(), locale: LocaleType.fa);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: AppColor.currentAppColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
          child: ListTile(
            onLongPress: longPressCallBack,
            title: Text(
              taskTitle,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  decoration: isChecked! ? TextDecoration.lineThrough : null),
            ),
            leading: Container(
              width: 72.0,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _getUserSelectedDateTime(context);
                    },
                    // onTap: () async => await _selectDate(context),
                    // () async => await showTimePicker(
                    //   confirmText: 'تایید',
                    //   cancelText: 'لغو',
                    //   hourLabelText: 'ساعت',
                    //   minuteLabelText: 'دقیقه',
                    //   helpText: 'زمان آلارم',
                    //   errorInvalidText: 'لطفا یک زمان صحیح وارد کنید',
                    //   builder: (context, child) {
                    //     return Theme(
                    //       data: Theme.of(context).copyWith(
                    //         colorScheme: ColorScheme.light(
                    //           primary: AppColor.currentAppColor,
                    //         ),
                    //       ),
                    //       child: Directionality(
                    //         textDirection: TextDirection.rtl,
                    //         child: child!,
                    //       ),
                    //     );
                    //   },
                    //   context: context,
                    //   initialTime: TimeOfDay.now(),
                    // ),
                    child: const Icon(
                      Icons.notification_add_outlined,
                      color: Color(0xFF757575),
                    ),
                  ),
                  Checkbox(
                    activeColor: AppColor.currentAppColor,
                    value: isChecked,
                    onChanged: checkboxCallback,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
