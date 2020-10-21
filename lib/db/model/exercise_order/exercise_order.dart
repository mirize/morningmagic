import 'package:hive/hive.dart';

import 'exercise_pair.dart';

@HiveType(typeId: 1)
class ExerciseOrder extends HiveObject {

  @HiveField(0)
  List<ExercisePair> exerciseLit;
}