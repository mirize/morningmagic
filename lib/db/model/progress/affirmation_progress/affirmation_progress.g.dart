// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affirmation_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AffirmationProgressAdapter extends TypeAdapter<AffirmationProgress> {
  @override
  final typeId = 10;

  @override
  AffirmationProgress read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AffirmationProgress(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AffirmationProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.seconds)
      ..writeByte(1)
      ..write(obj.text);
  }
}
