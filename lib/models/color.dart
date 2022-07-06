import 'package:hive/hive.dart';

part 'color.g.dart';

@HiveType(typeId: 1)
class ColorSchemeRoozane extends HiveObject {
  @HiveField(0)
  late int hex;
}
