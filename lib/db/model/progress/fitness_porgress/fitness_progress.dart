import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'fitness_progress.g.dart';

@HiveType(typeId: 14)
class FitnessProgress extends Exercise {

  FitnessProgress(this.seconds, this.exercise);

  String title = "Фитнес";

  @HiveField(0)
  int seconds;

  @HiveField(1)
  String exercise;

  @override
  String toString() {
    return 'FitnessProgress{title: $title, seconds: $seconds, exercise: $exercise}';
  }


}