import 'package:flutter/material.dart';

final _firstApodDate = DateTime.utc(1995, 6, 16);

Future<DateTime> showApodDatePicker(BuildContext context) async {
  return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _firstApodDate,
      lastDate: DateTime.now()
  );
}