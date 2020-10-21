class StringUtil {
  String createTimeString(int _time) {
    int min;
    int sec;
    String seconds;
    String minutes;

    if (_time != null) {
      min = _time ~/ 60;
      sec = _time % 60;
      int length_seconds = sec.toString().length;
      int length_minutes = min.toString().length;

      if (length_seconds < 2) {
        seconds = '0' + sec.toString();
      } else {
        seconds = sec.toString();
      }

      if (length_minutes < 2) {
        minutes = '0' + min.toString();
      } else {
        minutes = min.toString();
      }
      return minutes + " : " + seconds;

    } else {
      return "";
    }
  }

  String createTimeAppBarString(int _time) {
    int min;
    int sec;
    String seconds;
    String minutes;

    if (_time != null) {
      min = _time ~/ 60;
      sec = _time % 60;
      int length_seconds = sec.toString().length;
      int length_minutes = min.toString().length;

      if (length_seconds < 2) {
        seconds = '0' + sec.toString();
      } else {
        seconds = sec.toString();
      }

      if (length_minutes < 2) {
        minutes = '0' + min.toString();
      } else {
        minutes = min.toString();
      }
      return minutes + " : " + seconds;

    } else {
      return "00 : 00";
    }
  }
}