import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
DateFormat dateOnlyFormat = DateFormat("yyyy-MM-dd");

var now = dateFormat.parse("${dateOnlyFormat.format(DateTime.now())} 00:00:00");
DateTime plus(int days) => now.add(Duration(days: days));
DateTime minus(days) => now.subtract(Duration(days: days));
var today = DateTime.now().weekday;

class WeekdayController extends ChangeNotifier {
//  DateTime startTime;
//  DateTime endTime;
//  String date = dateOnlyFormat.format(DateTime.now());

  var monStart;
  var monEnd;
  var tueStart;
  var tueEnd;
  var wedStart;
  var wedEnd;
  var thuStart;
  var thuEnd;
  var friStart;
  var friEnd;
  var satStart;
  var satEnd;
  var sunStart;
  var sunEnd;

  DateTime getStartTime(int day) {
    if (today == 1) {
      monStart = now;
      tueStart = plus(1);
      wedStart = plus(2);
      thuStart = plus(3);
      friStart = plus(4);
      satStart = plus(5);
      sunStart = plus(6);

      notifyListeners();
    }
    if (today == 2) {
      monStart = minus(1);
      tueStart = now;
      wedStart = plus(1);
      thuStart = plus(2);
      friStart = plus(3);
      satStart = plus(4);
      sunStart = plus(5);

      notifyListeners();
    }
    if (today == 3) {
      monStart = minus(2);
      tueStart = minus(1);
      wedStart = now;
      thuStart = plus(1);
      friStart = plus(2);
      satStart = plus(3);
      sunStart = plus(4);

      notifyListeners();
    }
    if (today == 4) {
      monStart = minus(3);
      tueStart = minus(2);
      wedStart = minus(1);
      thuStart = now;
      friStart = plus(1);
      satStart = plus(2);
      sunStart = plus(3);

      notifyListeners();
    }
    if (today == 5) {
      monStart = minus(4);
      tueStart = minus(3);
      wedStart = minus(2);
      thuStart = minus(1);
      friStart = now;
      satStart = plus(1);
      sunStart = plus(2);

      notifyListeners();
    }
    if (today == 6) {
      monStart = minus(5);
      tueStart = minus(4);
      wedStart = minus(3);
      thuStart = minus(2);
      friStart = minus(1);
      satStart = now;
      sunStart = plus(1);

      notifyListeners();
    }
    if (today == 7) {
      monStart = minus(6);
      tueStart = minus(5);
      wedStart = minus(4);
      thuStart = minus(3);
      friStart = minus(2);
      satStart = minus(1);
      sunStart = now;

      notifyListeners();
    }

    return day == 1
        ? monStart
        : day == 2
            ? tueStart
            : day == 3
                ? wedStart
                : day == 4
                    ? thuStart
                    : day == 5
                        ? friStart
                        : day == 6 ? satStart : day == 7 ? sunStart : now;
  }

  DateTime getEndTime(day) {
    if (today == 1) {
      monEnd = plus(1);
      tueEnd = plus(2);
      wedEnd = plus(3);
      thuEnd = plus(4);
      friEnd = plus(5);
      satEnd = plus(6);
      sunEnd = plus(7);

      notifyListeners();
    }
    if (today == 2) {
      monEnd = now;
      tueEnd = plus(1);
      wedEnd = plus(2);
      thuEnd = plus(3);
      friEnd = plus(4);
      satEnd = plus(5);
      sunEnd = plus(6);

      notifyListeners();
    }
    if (today == 3) {
      monEnd = minus(1);
      tueEnd = now;
      wedEnd = plus(1);
      thuEnd = plus(2);
      friEnd = plus(3);
      satEnd = plus(4);
      sunEnd = plus(5);

      notifyListeners();
    }
    if (today == 4) {
      monEnd = minus(2);
      tueEnd = minus(1);
      wedEnd = now;
      thuEnd = plus(1);
      friEnd = plus(2);
      satEnd = plus(3);
      sunEnd = plus(4);

      notifyListeners();
    }
    if (today == 5) {
      monEnd = minus(3);
      tueEnd = minus(2);
      wedEnd = minus(1);
      thuEnd = now;
      friEnd = plus(1);
      satEnd = plus(2);
      sunEnd = plus(3);

      notifyListeners();
    }
    if (today == 6) {
      monEnd = minus(4);
      tueEnd = minus(3);
      wedEnd = minus(2);
      thuEnd = minus(1);
      friEnd = now;
      satEnd = plus(1);
      sunEnd = plus(2);

      notifyListeners();
    }
    if (today == 7) {
      monEnd = minus(5);
      tueEnd = minus(4);
      wedEnd = minus(3);
      thuEnd = minus(2);
      friEnd = minus(1);
      satEnd = now;
      sunEnd = plus(1);

      notifyListeners();
    }

    return day == 1
        ? monEnd
        : day == 2
            ? tueEnd
            : day == 3
                ? wedEnd
                : day == 4
                    ? thuEnd
                    : day == 5
                        ? friEnd
                        : day == 6 ? satEnd : day == 7 ? sunEnd : now;
  }
}
