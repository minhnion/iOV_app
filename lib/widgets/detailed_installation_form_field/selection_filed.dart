
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/widgets/categories_search/categories_search.dart';

class SelectionFiled extends StatefulWidget {
  final String label;
  final String initialValue;
  final bool isEditable;
  final Function(String) onValueChanged;

  const SelectionFiled({
    super.key,
    required this.label,
    this.initialValue = '',
    this.isEditable = false,
    required this.onValueChanged,
  });

  @override
  State<SelectionFiled> createState() => _SelectionFiledState();
}

class _SelectionFiledState extends State<SelectionFiled> {
  final List<String> _jobCategories = [
    "Lắp đặt bản demo",
    "New Install",
    "Lắp đặt lại",
    "Dán để di chuyển xe",
    "Sửa chữa / khắc phục",
    "Gỡ bỏ OneLink",
    "Tháo tại khách hàng"
  ];
  List<String> _selectedJobCategories = [];
  @override
  void initState() {
    super.initState();
    if (widget.initialValue.isNotEmpty) {
      if (_jobCategories.contains(widget.initialValue)) {
        _selectedJobCategories = [widget.initialValue];
      } else {
        final values = widget.initialValue.split(',');
        _selectedJobCategories = values.where((value) =>
            _jobCategories.contains(value.trim())
        ).toList();
      }
    }
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
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                fillColor: widget.isEditable ? Colors.white : Colors.grey.shade200,
                hintText: _selectedJobCategories.isEmpty ?""
                    :_selectedJobCategories.join(","),
                filled: !widget.isEditable,
              ),
              readOnly: true,
                enabled: widget.isEditable,
              onTap: widget.isEditable ? () {
                showDialog(context: context, builder: (context) {
                  return CategoriesSearch(
                    categoriesList: _jobCategories,
                    selectedCategories: _selectedJobCategories,
                    onSelectionChanged: (selected) {
                      setState(() {
                        _selectedJobCategories = selected;

                        if(selected.isNotEmpty) {
                          widget.onValueChanged(selected.join(','));
                        } else {
                          widget.onValueChanged('');
                        }
                      });
                    },
                  );
                });
              } : null,
            ),
          )
        ],
      ),
    );
  }
}
