// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeditationProgressAdapter extends TypeAdapter<MeditationProgress> {
  @override
  final typeId = 11;

  @override
  MeditationProgress read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeditationProgress(
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MeditationProgress obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.seconds);
  }
}
