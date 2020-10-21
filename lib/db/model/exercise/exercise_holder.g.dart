// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseHolderAdapter extends TypeAdapter<ExerciseHolder> {
  @override
  final typeId = 50;

  @override
  ExerciseHolder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseHolder(
      (fields[0] as List)?.cast<ExerciseTitle>(),
      (fields[1] as List)?.cast<ExerciseTitle>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseHolder obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.freshExercises)
      ..writeByte(1)
      ..write(obj.skipExercises);
  }
}
