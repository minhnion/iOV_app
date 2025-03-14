import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> selectedDate(BuildContext context, TextEditingController controller) async {
  DateTime? picked = await showDatePicker(
      context: context,
      locale: context.locale,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));
  if (picked != null) {
    controller.text = "${picked.year}-${picked.month}-${picked.day}";
  }
}