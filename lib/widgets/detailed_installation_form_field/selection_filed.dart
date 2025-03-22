
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/widgets/categories_search/categories_search.dart';

class SelectionFiled extends StatefulWidget {
  final String label;
  final String initialValue;
  final bool isEditable;
  const SelectionFiled({super.key, required this.label,this.initialValue = '',this.isEditable = false,});

  @override
  State<SelectionFiled> createState() => _SelectionFiledState();
}

class _SelectionFiledState extends State<SelectionFiled> {
  final List<String> _jobCategories = [
    "Lắp đặt bản demo",
    "Lắp đặt mới",
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
    _selectedJobCategories = widget.initialValue.isNotEmpty
        ? [widget.initialValue]
        : [];
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
