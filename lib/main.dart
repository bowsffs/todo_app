import 'package:flutter/material.dart';
import 'package:todo_app/models/state.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/color.dart';
import 'package:todo_app/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(ColorSchemeRoozaneAdapter());
  Hive.registerAdapter(StateRoozaneAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<ColorSchemeRoozane>('color');
  await Hive.openBox<StateRoozane>('state');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Dirooz'),
        home: TasksScreen(),
      ),
    );
  }
}
