import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';


part 'day_holder.g.dart';

@HiveType(typeId: 12)
class DayHolder extends HiveObject {

  DayHolder(this.listOfDays);

  @HiveField(0)
  List<Day> listOfDays;

  @override
  String toString() {
    return 'DayHolder{listOfDays: $listOfDays}';
  }


}