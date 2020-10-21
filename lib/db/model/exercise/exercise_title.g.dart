// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_title.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseTitleAdapter extends TypeAdapter<ExerciseTitle> {
  @override
  final typeId = 51;

  @override
  ExerciseTitle read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseTitle(
      fields[0] as String,
      fields[1] as double,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseTitle obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.size)
      ..writeByte(2)
      ..write(obj.key);
  }
}
