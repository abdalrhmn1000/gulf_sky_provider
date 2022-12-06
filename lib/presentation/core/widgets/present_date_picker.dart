import 'package:flutter/material.dart';

Future<DateTime?> presentDatePicker(
  BuildContext context,
  DateTime? oldDate, {
  DateTime? lastDate,
  DateTime? firstDate,
  String? label,
}) async {
  final newDate = await showDatePicker(
    builder: (context, child) {
      return Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).primaryColor,
          ),
        //  dialogBackgroundColor: Theme.of(context).cardColor,
        ),
        child: child ?? const Text(''),
      );
    },
    context: context,
    initialDate: oldDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ?? DateTime.now(),
    fieldLabelText: label,
    helpText: label,
  );

  return newDate;
}
