// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorSchemeRoozaneAdapter extends TypeAdapter<ColorSchemeRoozane> {
  @override
  final int typeId = 1;

  @override
  ColorSchemeRoozane read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColorSchemeRoozane()..hex = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, ColorSchemeRoozane obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.hex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorSchemeRoozaneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
