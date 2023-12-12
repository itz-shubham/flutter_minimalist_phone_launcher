import 'dart:async';

import 'package:intl/intl.dart';

final timeFormatter = DateFormat('h:mm  a');
final dateFormatter = DateFormat('EEEE d MMMM');

class DeviceTime {
  final String time, date;
  DeviceTime({required this.time, required this.date});
  // final int hours, minutes;
  // final String date, dayName, month;

  // DeviceTime({
  //   required this.hours,
  //   required this.minutes,
  //   required this.dayName,
  //   required this.month,
  //   required this.date,
  // });

  static Stream<DeviceTime> currentDateTime() async* {
    final currentTime = DateTime.now();
    final timeText = timeFormatter.format(currentTime);
    final dateText = dateFormatter.format(currentTime);
    yield DeviceTime(time: timeText, date: dateText);
    //  Timer.periodic(Duration(seconds: 1), (_) {
    //     var currentTime = DateTime.now();
    //     yield
    //   });
    //(Duration(seconds: 1)).listen((event) =>event);

    // Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {

    // });
    print(currentTime);
  }
}
