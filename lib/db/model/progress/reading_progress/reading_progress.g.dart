// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReadingProgressAdapter extends TypeAdapter<ReadingProgress> {
  @override
  final typeId = 15;

  @override
  ReadingProgress read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReadingProgress(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReadingProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.book)
      ..writeByte(1)
      ..write(obj.pages);
  }
}
