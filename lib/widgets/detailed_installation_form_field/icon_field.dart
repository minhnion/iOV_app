import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/utils/barcode_scanner.dart';
import 'package:iov_app/utils/date_picker.dart';

class IconField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final String keyField;
  final String initialValue;


  const IconField(
      {super.key, required this.label, this.icon, required this.keyField, this.initialValue = ''});

  @override
  State<IconField> createState() => _IconFieldState();
}

class _IconFieldState extends State<IconField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  fillColor: Colors.grey.shade700,
                  suffixIcon: widget.icon != null
                      ? IconButton(
                          icon: Icon(widget.icon),
                          onPressed: () async{
                            if (widget.keyField == "date") {
                              selectedDate(context, _controller);
                            }
                            if(widget.keyField == "barcode"){
                              String? result = await scanBarcode(context);
                              if(result!=null){
                                _controller.text=result;
                              }
                            }
                          },
                        )
                      : null),
              readOnly: false,
            ),
          )
        ],
      ),
    );
  }
}
