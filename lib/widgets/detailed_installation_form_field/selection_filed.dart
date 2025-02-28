
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/screens/detailed_installation/detailed_installation.dart';
import 'package:iov_app/widgets/categories_search/categories_search.dart';

class SelectionFiled extends StatefulWidget {
  final String label;
  const SelectionFiled({super.key, required this.label});

  @override
  State<SelectionFiled> createState() => _SelectionFiledState();
}

class _SelectionFiledState extends State<SelectionFiled> {
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
                fillColor: Colors.grey.shade700
              ),
              readOnly: true,
              onTap: (){
                showDialog(context: context, builder: (context) {
                  return CategoriesSearch(
                    categoriesList: [],
                    selectedCategories: [],
                    onSelectionChanged: (selectedCategories) {
                      setState(() {
                        print("Danh mục đã chọn: $selectedCategories");
                      });
                    },
                  );
                });
              }
            ),
          )
        ],
      ),
    );
  }
}
