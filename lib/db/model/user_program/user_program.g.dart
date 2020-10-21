// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_program.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProgramAdapter extends TypeAdapter<UserProgram> {
  @override
  final typeId = 220;

  @override
  UserProgram read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProgram(
      (fields[0] as List)?.cast<ExerciseTitle>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProgram obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.exercises);
  }
}
