import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'package:morningmagic/db/model/note/note.dart';
import 'package:morningmagic/db/model/progress/reading_progress/reading_progress.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_record_progress.dart';
import 'package:morningmagic/db/model/visualization/visualization_adapter.dart';

import 'model/affirmation_text/affirmation_text_adapter.dart';
import 'model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'model/app_and_custom_exercises/app_exercise_holder.dart';
import 'model/app_and_custom_exercises/exercise_name.dart';
import 'model/book/book_adapter.dart';
import 'model/exercise/exercise_holder.dart';
import 'model/exercise/exercise_title.dart';
import 'model/exercise_time/exercise_time_adapter.dart';
import 'model/progress/affirmation_progress/affirmation_progress.dart';
import 'model/progress/day/day.dart';
import 'model/progress/day/day_holder.dart';
import 'model/progress/fitness_porgress/fitness_progress.dart';
import 'model/progress/meditation_progress/meditation_progress.dart';
import 'model/progress/vocabulary_progress/vocabulary_note_progress.dart';
import 'model/reordering_program/order_holder.dart';
import 'model/reordering_program/order_item.dart';
import 'model/user/user_adapter.dart';
import 'model/user_program/user_program.dart';

class MyDB {

  Future<void> initHiveDatabase() async {

    await Hive.initFlutter();

    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(AffirmationTextAdapter());
    Hive.registerAdapter(BookAdapter());
    Hive.registerAdapter(ExerciseTimeAdapter());
    Hive.registerAdapter(VisualizationAdapter());
    Hive.registerAdapter(DayAdapter());
    Hive.registerAdapter(AffirmationProgressAdapter());
    Hive.registerAdapter(MeditationProgressAdapter());
    Hive.registerAdapter(VisualizationProgressAdapter());
    Hive.registerAdapter(FitnessProgressAdapter());
    Hive.registerAdapter(ReadingProgressAdapter());
    Hive.registerAdapter(DayHolderAdapter());
    Hive.registerAdapter(VocabularyNoteProgressAdapter());
    Hive.registerAdapter(VocabularyRecordProgressAdapter());
    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(ExerciseHolderAdapter());
    Hive.registerAdapter(ExerciseTitleAdapter());
    Hive.registerAdapter(ExerciseNameAdapter());
    Hive.registerAdapter(CustomExerciseHolderAdapter());
    Hive.registerAdapter(AppExerciseHolderAdapter());
    Hive.registerAdapter(OrderItemAdapter());
    Hive.registerAdapter(OrderHolderAdapter());
    Hive.registerAdapter(UserProgramAdapter());
  }
}