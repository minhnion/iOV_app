import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ConfirmInform extends StatelessWidget {
  const ConfirmInform({super.key, required this.title, required this.content, required this.onConfirm});
  final String title;
  final String content;
  final Function() onConfirm;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0), // Rounded corners
      ),
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
      ),
      content: Text(
        content,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 16.0),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
          },
          child: Text(
            "cancel".tr(),
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
        TextButton(
          onPressed: () {
            // Perform logout action here
            onConfirm();
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.red, fontSize: 16.0),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.end,
    );
  }
}
