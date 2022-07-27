import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:todo_app/calender_events/gregorian.dart';
import 'package:todo_app/calender_events/persian.dart';
import 'package:todo_app/calender_events/hejri.dart';

class EventApi {
  static List<Map<String, Object>> getEventsByDateTime(DateTime date) {
    List<Map<String, Object>>? events = [];
    Jalali jalaliDate = date.toJalali();
    HijriCalendar hijriDate = HijriCalendar.fromDate(date);

    var gregEv = gregorianEvent.firstWhere(
      (element) => element['Day'] == date.day && element['Month'] == date.month,
      orElse: () => {},
    );

    if (gregEv.isNotEmpty) {
      events.add(gregEv);
    }

    var hijriEv = hejriEvent.firstWhere(
      (element) =>
          element['Day'] == hijriDate.hDay &&
          element['Month'] == hijriDate.hMonth,
      orElse: () => {},
    );
    if (hijriEv.isNotEmpty) {
      events.add(hijriEv);
    }

    var persianEv = persianEvent.firstWhere(
      (element) =>
          element['Day'] == jalaliDate.day &&
          element['Month'] == jalaliDate.month,
      orElse: () => {},
    );

    if (persianEv.isNotEmpty) {
      events.add(persianEv);
    }

    return events;
  }
}
