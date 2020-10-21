import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'vocabulary_note_progress.g.dart';

@HiveType(typeId: 35)
class VocabularyNoteProgress extends Exercise {

  VocabularyNoteProgress(this.note);

  String title = "Дневник";

  @HiveField(0)
  String note;

  @override
  String toString() {
    return 'VocabularyProgress{title: $title, note: $note}';
  }


}