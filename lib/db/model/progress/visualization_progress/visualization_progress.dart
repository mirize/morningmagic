import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'visualization_progress.g.dart';

@HiveType(typeId: 17)
class VisualizationProgress extends Exercise {

  VisualizationProgress(this.seconds, this.text);

  String title = "Визуализация";

  @HiveField(0)
  int seconds;

  @HiveField(1)
  String text;

  @override
  String toString() {
    return 'VisualizationProgress{title: $title, seconds: $seconds, text: $text}';
  }

}