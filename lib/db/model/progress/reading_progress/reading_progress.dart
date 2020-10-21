import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'reading_progress.g.dart';

@HiveType(typeId: 15)
class ReadingProgress extends Exercise {

  ReadingProgress(this.book, this.pages);

  String title = "Чтение";

  @HiveField(0)
  String book;

  @HiveField(1)
  int pages;

  @override
  String toString() {
    return 'ReadingProgress{title: $title, book: $book, pages: $pages}';
  }


}