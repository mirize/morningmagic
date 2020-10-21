import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';

class ExerciseTimeAdapter extends TypeAdapter<ExerciseTime> {

  @override
  final typeId = 3;

  @override
  ExerciseTime read(BinaryReader reader) {
    return ExerciseTime(reader.read());
  }

  @override
  void write(BinaryWriter writer, ExerciseTime obj) {
    writer.write(obj.time);
  }

}