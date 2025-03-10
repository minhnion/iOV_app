import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/utils/barcode_scanner.dart';
import 'package:iov_app/utils/date_picker.dart';

class IconField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String keyField;

  const IconField(
      {super.key, required this.label, this.icon, required this.keyField});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

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
              controller: _controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: Colors.grey.shade700,
                  suffixIcon: icon != null
                      ? IconButton(
                          icon: Icon(icon),
                          onPressed: () async{
                            if (keyField == "date") {
                              selectedDate(context, _controller);
                            }
                            if(keyField == "barcode"){
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
