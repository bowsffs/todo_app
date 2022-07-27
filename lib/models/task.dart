import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  List<String> subTasks = [];

  @HiveField(2)
  Map<String, bool> options = {
    'isDone': false,
    'isStarred': false,
    'notification': false,
    'iteration': true
  };

  @HiveField(3)
  DateTime? notificationAndAlarmDate;

  @HiveField(4)
  late DateTime initDate;

  @HiveField(5)
  String notificationSound = "sound1";
}
