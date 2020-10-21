import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'affirmation_progress.g.dart';

@HiveType(typeId: 10)
class AffirmationProgress extends Exercise {

  AffirmationProgress(this.seconds, this.text);

  String title = "Аффермации";

  @HiveField(0)
  int seconds;

  @HiveField(1)
  String text;

  @override
  String toString() {
    return 'AffirmationProgress{title: $title, seconds: $seconds, text: $text}';
  }

}