import 'package:test/test.dart';
import 'package:todo_app/modules/events.dart';

void main() {
  group('Roozane', () {
    test('Bayad etefaghate 2022 6 10 ra be ma bedahad', () {
      DateTime testDay = DateTime(2022, 6, 10);
      var result = EventApi.getEventsByDateTime(testDay);
      expect(result, [
        {'Title': ' روز جهاني صنايع دستي', 'Day': 10, 'Month': 6},
        {
          'Title': 'ولادت حضرت امام رضا عليه السلام، 148 هـ ق',
          'Day': 11,
          'Month': 11
        },
        {
          'Title':
              'شهادت آيت‌الله سعيدي به دست مأموران ستم شاهي پهلوي، 1349 هـ ش',
          'Day': 20,
          'Month': 3
        }
      ]);
    });
    test('Bayad etefaghate 2022 8 12 ra be ma bedahad', () {
      DateTime testDay = DateTime(2022, 8, 12);
      var result = EventApi.getEventsByDateTime(testDay);
      expect(result, []);
    });
    test('Bayad etefaghate 2022 10 19 ra be ma bedahad', () {
      DateTime testDay = DateTime(2022, 10, 19);
      var result = EventApi.getEventsByDateTime(testDay);
      expect(result, []);
    });
    test('Bayad etefaghate 2022 9 5 ra be ma bedahad', () {
      DateTime testDay = DateTime(2022, 9, 5);
      var result = EventApi.getEventsByDateTime(testDay);
      expect(result, [
        {
          'Title': 'شهادت آيت الله قدوسي و سرتيپ وحيد دستجردي، 1360 هـ ش',
          'Day': 14,
          'Month': 6
        }
      ]);
    });
  });
}
