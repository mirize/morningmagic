import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class AffirmationText extends HiveObject {

  AffirmationText(this.affirmationText);

  @HiveField(0)
  String affirmationText;

  @override
  String toString() {
    return 'AffirmationText{affirmationText: $affirmationText}';
  }


}