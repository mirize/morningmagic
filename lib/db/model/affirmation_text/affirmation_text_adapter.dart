import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/affirmation_text/affirmation_text.dart';

class AffirmationTextAdapter extends TypeAdapter<AffirmationText> {

  @override
  final typeId = 1;

  @override
  AffirmationText read(BinaryReader reader) {
    return AffirmationText(reader.read());
  }

  @override
  void write(BinaryWriter writer, AffirmationText obj) {
    writer.write(obj.affirmationText);
  }

}