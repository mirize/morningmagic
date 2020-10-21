import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/affirmation_progress/affirmation_progress.dart';
import 'package:morningmagic/db/model/progress/fitness_porgress/fitness_progress.dart';
import 'package:morningmagic/db/model/progress/meditation_progress/meditation_progress.dart';
import 'package:morningmagic/db/model/progress/reading_progress/reading_progress.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_note_progress.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_record_progress.dart';


part 'day.g.dart';


@HiveType(typeId: 13)
class Day extends HiveObject {

  Day(this.date, this.affirmationProgress, this.meditationProgress,
      this.fitnessProgress, this.readingProgress, this.vocabularyNoteProgress,
      this.vocabularyRecordProgress, this.visualizationProgress);

  @HiveField(0)
  String date;

  @HiveField(1)
  AffirmationProgress affirmationProgress;

  @HiveField(2)
  MeditationProgress meditationProgress;

  @HiveField(3)
  FitnessProgress fitnessProgress;

  @HiveField(4)
  ReadingProgress readingProgress;

  @HiveField(5)
  VocabularyNoteProgress vocabularyNoteProgress;

  @HiveField(6)
  VocabularyRecordProgress vocabularyRecordProgress;

  @HiveField(7)
  VisualizationProgress visualizationProgress;

  @override
  String toString() {
    return 'Day{date: $date, affirmationProgress: $affirmationProgress,'
        ' meditationProgress: $meditationProgress, '
        'fitnessProgress: $fitnessProgress, readingProgress: '
        '$readingProgress, vocabularyNoteProgress: $vocabularyNoteProgress, '
        'vocabularyRecordProgress: $vocabularyRecordProgress, '
        'visualizationProgress: $visualizationProgress}';
  }


}