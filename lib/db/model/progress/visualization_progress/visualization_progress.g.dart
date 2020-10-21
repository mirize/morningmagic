// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visualization_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisualizationProgressAdapter extends TypeAdapter<VisualizationProgress> {
  @override
  final typeId = 17;

  @override
  VisualizationProgress read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VisualizationProgress(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VisualizationProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.seconds)
      ..writeByte(1)
      ..write(obj.text);
  }
}
