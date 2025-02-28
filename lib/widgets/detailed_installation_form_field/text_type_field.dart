
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TextTypeField extends StatelessWidget {
  final String label;
  const TextTypeField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textTypeController =  TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label.tr(),
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey.shade700
                ),
                controller: _textTypeController,
            ),
          )
        ],
      ),
    );
  }
}
