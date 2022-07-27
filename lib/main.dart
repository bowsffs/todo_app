import 'package:flutter/material.dart';
import 'package:todo_app/models/state.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/color.dart';
import 'package:todo_app/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/task_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(ColorSchemeRoozaneAdapter());
  Hive.registerAdapter(StateRoozaneAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<ColorSchemeRoozane>('color');
  await Hive.openBox<StateRoozane>('state');

  tz.initializeTimeZones();

  runApp(const Roozane());
}

class Roozane extends StatelessWidget {
  const Roozane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        title: 'Roozaneh',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Dirooz',
        ),
        home: const TasksScreen(),
      ),
    );
  }
}
