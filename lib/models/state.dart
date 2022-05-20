import 'package:hive/hive.dart';

part 'state.g.dart';

@HiveType(typeId: 2)
class StateRoozane extends HiveObject {
  @HiveField(0)
  late bool appFirstTimeRun;
}
