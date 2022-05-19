import 'package:hive/hive.dart';
import 'package:todo_app/models/task.dart';

class Boxes {
  static Box<Task> getTasks() => Hive.box<Task>('tasks');
}
