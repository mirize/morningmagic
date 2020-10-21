import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/exercise_order/exercise_enum.dart';

@HiveType(typeId: 2)
class ExercisePair extends HiveObject {

  @HiveField(0)
  int position;

  @HiveField(1)
  ExerciseType type;

}