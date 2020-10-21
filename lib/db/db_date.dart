class DBDate {
  String getStringDate() {

    String result = "";
    DateTime dateTime = DateTime.now();

    String day = dateTime.day.toString();
    if (day.length < 2) {
      day = "0" + day;
    }

    String month = dateTime.month.toString();
    if (month.length < 2) {
      month = "0" + month;
    }

    String year = dateTime.year.toString();
    year = year.substring(2);

    result = day + "." + month + "." + year;

    return result;
  }
}