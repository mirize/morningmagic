import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'vocabulary_record_progress.g.dart';

@HiveType(typeId: 45)
class VocabularyRecordProgress extends Exercise {

  VocabularyRecordProgress(this.path);

  String title = "Дневник";

  @HiveField(0)
  String path;

  @override
  String toString() {
    return 'VocabularyRecordProgress{title: $title, path: $path}';
  }

}