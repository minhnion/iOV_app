import 'package:flutter/material.dart';

class CategoriesSearch extends StatefulWidget {
  const CategoriesSearch({
    super.key,
    required this.categoriesList,
    required this.selectedCategories,
    required this.onSelectionChanged,
  });

  final List<String> categoriesList;
  final List<String> selectedCategories;
  final Function(List<String>) onSelectionChanged;

  @override
  State<CategoriesSearch> createState() => _CategoriesSearchState();
}

class _CategoriesSearchState extends State<CategoriesSearch> {
  late List<String> _tempSelectedCategories;

  @override
  void initState() {
    super.initState();
    _tempSelectedCategories = List.from(widget.selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 24, 14, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600],)
              ),
            ),
            const SizedBox(height: 16.0),

            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: widget.categoriesList.length,
                itemBuilder: (context, index) {
                  final category = widget.categoriesList[index];
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(category),
                    value: _tempSelectedCategories.contains(category),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _tempSelectedCategories.add(category);
                        } else {
                          _tempSelectedCategories.remove(category);
                        }
                      });
                    },
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _tempSelectedCategories = List.from(widget.categoriesList);
                    });
                  },
                  child: const Text(
                      'Chọn tất cả',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onSelectionChanged(_tempSelectedCategories);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                      'Hoàn thành',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
