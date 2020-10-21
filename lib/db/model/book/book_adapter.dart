import 'package:hive/hive.dart';

import 'book.dart';

class BookAdapter extends TypeAdapter<Book> {

  @override
  final typeId = 2;

  @override
  Book read(BinaryReader reader) {
    return Book(reader.read());
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer.write(obj.bookName);
  }
}