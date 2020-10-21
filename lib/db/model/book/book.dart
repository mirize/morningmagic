import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class Book extends HiveObject {

  Book(this.bookName);

  @HiveField(0)
  String bookName;

  @override
  String toString() {
    return 'Book{bookName: $bookName}';
  }


}