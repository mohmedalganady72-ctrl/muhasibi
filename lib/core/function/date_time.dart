import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

Map<String, String> getDateTime() {
  Map<String, String> result = {};
  DateTime now = DateTime.now();

  result['date'] = DateFormat('dd/MM/yyyy').format(now);
  result['time'] = DateFormat('hh:mm a').format(now);

  return result;
}

Future<Map<String, dynamic>> getDataTimerCelunderFun(BuildContext context,
    OmniDateTimePickerType type, DateTime? initialDate) async {
  DateTime? dateTime = await showOmniDateTimePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(1600),
    lastDate: DateTime.now().add(const Duration(days: 3652)),
    is24HourMode: false,
    isShowSeconds: false,
    type: type,
    barrierDismissible: true,
    borderRadius: const BorderRadius.all(Radius.circular(0)),
    // theme: ThemeData.light(),
    isForce2Digits: true,
  );

  if (dateTime != null) {
    // clientDateTime = dateTime;
    String clientDate = DateFormat("dd/MM/yyyy").format(dateTime);
    String clientTime = DateFormat("hh:mm a").format(dateTime);
    // dateController.text = "$clientDate $clientTime";

    return {
      "dataTime": dateTime,
      "date": clientDate,
      "time": clientTime,
    };

    // يحدث الـ UI مباشرة
  } else {
    return {
      "dataTime": initialDate ?? DateTime.now(),
      "date": DateFormat("dd/MM/yyyy").format(initialDate ?? DateTime.now()),
      "time": DateFormat("hh:mm a").format(initialDate ?? DateTime.now()),
    };
  }
}

DateTime parseDate(String date) {
  final parts = date.split("/"); // [day, month, year]
  final day = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final year = int.parse(parts[2]);
  return DateTime(year, month, day);
}

DateTime parseTime(String date) {
  final parts = date.split("/"); // [day, month, year]
  final day = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final year = int.parse(parts[2]);
  return DateTime(year, month, day);
}

DateTime parseToDateTime(String date, String time) {
  DateTime dDate = DateFormat('dd/MM/yyyy').parse(date);
  DateTime tTime = DateFormat('hh:mm a').parse(time);

  return DateTime(dDate.year, dDate.month, dDate.day, tTime.hour, tTime.minute);
}
