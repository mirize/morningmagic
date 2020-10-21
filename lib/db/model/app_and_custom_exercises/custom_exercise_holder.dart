import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';


part 'custom_exercise_holder.g.dart';

@HiveType(typeId: 102)
class CustomExerciseHolder {

  CustomExerciseHolder(this.list);

  @HiveField(0)
  List<ExerciseName> list;

  @override
  String toString() {
    return 'CustomExerciseHolder{list: $list}';
  }
}