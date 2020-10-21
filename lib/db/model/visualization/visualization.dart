import 'package:hive/hive.dart';

@HiveType(typeId: 6)
class Visualization extends HiveObject {

  Visualization(this.visualization);

  @HiveField(0)
  String visualization;

  @override
  String toString() {
    return 'Visualization{visualization: $visualization}';
  }


}