// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FitnessProgressAdapter extends TypeAdapter<FitnessProgress> {
  @override
  final typeId = 14;

  @override
  FitnessProgress read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FitnessProgress(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FitnessProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.seconds)
      ..writeByte(1)
      ..write(obj.exercise);
  }
}
