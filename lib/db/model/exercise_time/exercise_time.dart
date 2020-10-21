import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class ExerciseTime extends HiveObject {

  ExerciseTime(this.time);

  @HiveField(0)
  int time;

  @override
  String toString() {
    return 'ExerciseTime{time: $time}';
  }

}