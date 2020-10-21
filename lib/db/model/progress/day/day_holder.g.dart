// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayHolderAdapter extends TypeAdapter<DayHolder> {
  @override
  final typeId = 12;

  @override
  DayHolder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayHolder(
      (fields[0] as List)?.cast<Day>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayHolder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listOfDays);
  }
}
