import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';


part 'app_exercise_holder.g.dart';

@HiveType(typeId: 101)
class AppExerciseHolder {

  AppExerciseHolder(this.list);

  @HiveField(0)
  List<ExerciseName> list;

  @override
  String toString() {
    return 'AppExerciseHolder{list: $list}';
  }

}