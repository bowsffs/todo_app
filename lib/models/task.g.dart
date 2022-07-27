// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task()
      ..name = fields[0] as String
      ..subTasks = (fields[1] as List).cast<String>()
      ..options = (fields[2] as Map).cast<String, bool>()
      ..notificationAndAlarmDate = fields[3] as DateTime?
      ..initDate = fields[4] as DateTime
      ..notificationSound = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.subTasks)
      ..writeByte(2)
      ..write(obj.options)
      ..writeByte(3)
      ..write(obj.notificationAndAlarmDate)
      ..writeByte(4)
      ..write(obj.initDate)
      ..writeByte(5)
      ..write(obj.notificationSound);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
