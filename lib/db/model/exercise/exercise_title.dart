import 'package:hive/hive.dart';


part 'exercise_title.g.dart';

@HiveType(typeId: 51)
class ExerciseTitle extends HiveObject {

  ExerciseTitle(this.title, this.size, this.key);

  @HiveField(0)
  String title;

  @HiveField(1)
  double size;

  @HiveField(2)
  String key;

  @override
  String toString() {
    return 'ExerciseTitle{title: $title, size: $size, key: $key}';
  }
}