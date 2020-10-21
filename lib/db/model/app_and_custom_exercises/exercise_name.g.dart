// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_name.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseNameAdapter extends TypeAdapter<ExerciseName> {
  @override
  final typeId = 100;

  @override
  ExerciseName read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseName(
      fields[0] as String,
      fields[1] as String,
      fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseName obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.size);
  }
}
