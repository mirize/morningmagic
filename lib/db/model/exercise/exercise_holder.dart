import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';


part 'exercise_holder.g.dart';

@HiveType(typeId: 50)
class ExerciseHolder extends HiveObject {

  ExerciseHolder(this.freshExercises, this.skipExercises);

  @HiveField(0)
  List<ExerciseTitle> freshExercises;

  @HiveField(1)
  List<ExerciseTitle> skipExercises;

  @override
  String toString() {
    return 'ExerciseHolder{freshExercises: $freshExercises, skipExercises: $skipExercises}';
  }

}