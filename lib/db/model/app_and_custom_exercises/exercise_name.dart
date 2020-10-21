import 'package:hive/hive.dart';

part 'exercise_name.g.dart';

@HiveType(typeId: 100)
class ExerciseName extends HiveObject {

  ExerciseName(this.id, this.title, this.size);

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double size;

}