import 'package:flutter/material.dart';

class DateTimePickerWidget {
  static Future<DateTime> pickDate({
    @required BuildContext context,
    @required DateTime initialDate,
  }) {
    var tempDate = initialDate.subtract(Duration(days: 0));
    DateTime firstDate = new DateTime(
      tempDate.year,
      tempDate.month,
      tempDate.day,
      0,
      0,
      0,
    );
    DateTime lastDate = DateTime(2050);

    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }

  static Future<TimeOfDay> pickTime({
    @required BuildContext context,
    @required TimeOfDay initialTime,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialTime,
    );
  }
}
