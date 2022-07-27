import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DatePickerFa {
  static Future<DateTime?> getUserSelectedDateTime(
      BuildContext context, Color primColor) async {
    DateTime? userSelectedDateTime;
    Jalali? userSelectedDate = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali.now(),
      lastDate: Jalali(1500),
    );

    TimeOfDay? userSelectedTime;

    if (userSelectedDate != null) {
      userSelectedTime = await showPersianTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (userSelectedTime != null) {
        var selectedDateGregorian = userSelectedDate.toGregorian();
        userSelectedDateTime = DateTime(
          selectedDateGregorian.year,
          selectedDateGregorian.month,
          selectedDateGregorian.day,
          userSelectedTime.hour,
          userSelectedTime.minute,
        );
        return userSelectedDateTime;
      }
    }
    return null;
  }
}
