import '../progress/day/day.dart';

class ProgressObject implements Comparable<ProgressObject> {
  ProgressObject(String date, List<Day> dayList) {
    this.dateTime = createDateTimeFromString(date);
    this.date = date;
    this.dayList = dayList;
  }

  @override
  int compareTo(ProgressObject other) {
    return this.dateTime.compareTo(other.dateTime);
  }

  DateTime dateTime;
  String date;
  List<Day> dayList;

  @override
  String toString() {
    return 'ProgressObject{date: $date, dayList: $dayList}';
  }

  DateTime createDateTimeFromString(String string) {
    String result = "";
    List<String> list = string.split('.');
    result = "20" + list[2] + list[1] + list[0];

    return DateTime.parse(result);
  }
}
