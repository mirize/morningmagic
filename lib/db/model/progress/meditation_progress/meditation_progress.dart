import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'meditation_progress.g.dart';

@HiveType(typeId: 11)
class MeditationProgress extends Exercise {

  MeditationProgress(this.seconds);

  String title = "Медитация";

  @HiveField(0)
  int seconds;

  @override
  String toString() {
    return 'MeditationProgress{title: $title, seconds: $seconds}';
  }


}