import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 20)
class Note extends HiveObject {

  Note(this.note);

  @HiveField(0)
  String note;

  @override
  String toString() {
    return 'Note{note: $note}';
  }

}