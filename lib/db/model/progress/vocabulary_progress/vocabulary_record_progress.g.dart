// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_record_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabularyRecordProgressAdapter
    extends TypeAdapter<VocabularyRecordProgress> {
  @override
  final typeId = 45;

  @override
  VocabularyRecordProgress read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabularyRecordProgress(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VocabularyRecordProgress obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.path);
  }
}
