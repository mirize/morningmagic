// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_note_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabularyNoteProgressAdapter
    extends TypeAdapter<VocabularyNoteProgress> {
  @override
  final typeId = 35;

  @override
  VocabularyNoteProgress read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabularyNoteProgress(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VocabularyNoteProgress obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.note);
  }
}
