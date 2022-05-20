import 'package:hive/hive.dart';
import 'package:todo_app/models/state.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/color.dart';

class Boxes {
  static Box<Task> getTasks() => Hive.box<Task>('tasks');
  static Box<ColorSchemeRoozane> getColor() =>
      Hive.box<ColorSchemeRoozane>('color');
  static Box<StateRoozane> getState() => Hive.box<StateRoozane>('state');
}
