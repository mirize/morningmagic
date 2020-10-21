// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_exercise_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppExerciseHolderAdapter extends TypeAdapter<AppExerciseHolder> {
  @override
  final typeId = 101;

  @override
  AppExerciseHolder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppExerciseHolder(
      (fields[0] as List)?.cast<ExerciseName>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppExerciseHolder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }
}
