// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_exercise_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomExerciseHolderAdapter extends TypeAdapter<CustomExerciseHolder> {
  @override
  final typeId = 102;

  @override
  CustomExerciseHolder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomExerciseHolder(
      (fields[0] as List)?.cast<ExerciseName>(),
    );
  }

  @override
  void write(BinaryWriter writer, CustomExerciseHolder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }
}
