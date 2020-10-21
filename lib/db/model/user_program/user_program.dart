import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';

part 'user_program.g.dart';

@HiveType(typeId: 220)
class UserProgram extends HiveObject {

  UserProgram(this.exercises);

  @HiveField(0)
  List<ExerciseTitle> exercises;

  @override
  String toString() {
    return 'UserProgram{exercises: $exercises}';
  }
}