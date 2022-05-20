// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StateRoozaneAdapter extends TypeAdapter<StateRoozane> {
  @override
  final int typeId = 2;

  @override
  StateRoozane read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StateRoozane()..appFirstTimeRun = fields[0] as bool;
  }

  @override
  void write(BinaryWriter writer, StateRoozane obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.appFirstTimeRun);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateRoozaneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
