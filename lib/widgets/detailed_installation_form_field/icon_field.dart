import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/utils/barcode_scanner.dart';
import 'package:iov_app/utils/date_picker.dart';

class IconField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final String keyField;
  final String initialValue;
  final bool isEditable;
  final Function(String) onValueChanged;

  const IconField(
      {super.key,
      required this.label,
      this.icon,
      required this.keyField,
      this.initialValue = '',
      this.isEditable = false,
      required this.onValueChanged});

  @override
  State<IconField> createState() => _IconFieldState();
}

class _IconFieldState extends State<IconField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);

    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    widget.onValueChanged(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              widget.label.tr(),
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor:
                      widget.isEditable ? Colors.white : Colors.grey.shade200,
                  filled: !widget.isEditable,
                  suffixIcon: widget.icon != null && widget.isEditable
                      ? IconButton(
                          icon: Icon(widget.icon),
                          onPressed: () async {
                            if (widget.keyField == "date") {
                              selectedDate(context, _controller);
                            }
                            if (widget.keyField == "barcode") {
                              String? result = await scanBarcode(context);
                              if (result != null) {
                                setState(() {
                                  _controller.text = result;
                                });
                              }
                            }
                          },
                        )
                      : widget.icon != null
                          ? Icon(widget.icon, color: Colors.grey.shade400)
                          : null),
              enabled: widget.isEditable,
              readOnly: !widget.isEditable,
            ),
          )
        ],
      ),
    );
  }
}
