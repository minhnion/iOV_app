import 'package:easy_localization/easy_localization.dart';
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
  late List<String> _filteredCategories;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tempSelectedCategories = List.from(widget.selectedCategories);
    _filteredCategories = List.from(widget.categoriesList);

    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCategories);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    final searchText = _searchController.text.toLowerCase();
    setState(() {
      if (searchText.isEmpty) {
        _filteredCategories = List.from(widget.categoriesList);
      } else {
        _filteredCategories = widget.categoriesList
            .where((category) => category.toLowerCase().contains(searchText))
            .toList();
      }
    });
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
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'search'.tr(),
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600],)
              ),
            ),
            const SizedBox(height: 16.0),

            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: _filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = _filteredCategories[index];
                  final isSelected = _tempSelectedCategories.contains(category);
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(category),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          if (!_tempSelectedCategories.contains(category)) {
                            _tempSelectedCategories.add(category);
                          }                        } else {
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
                  child: Text(
                      'select_all'.tr(),
                      style: const TextStyle(
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
                  child: Text(
                      'done'.tr(),
                      style: const TextStyle(
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
