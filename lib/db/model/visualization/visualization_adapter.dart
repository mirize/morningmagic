import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/visualization/visualization.dart';

class VisualizationAdapter extends TypeAdapter<Visualization> {

  @override
  final typeId = 4;

  @override
  Visualization read(BinaryReader reader) {
    return Visualization(reader.read());
  }

  @override
  void write(BinaryWriter writer, Visualization obj) {
    writer.write(obj.visualization);
  }
}