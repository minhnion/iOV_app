import 'package:flutter/material.dart';
import 'package:iov_app/widgets/categories_search/categories_search.dart';

import '../../utils/date_picker.dart';

class InstallationSearchForm extends StatefulWidget {
  final Function(String imeiNumber, String fromDate, String toDate, String status) onSearch;
  const InstallationSearchForm({super.key , required this.onSearch});

  @override
  State<InstallationSearchForm> createState() => _InstallationSearchFormState();
}

class _InstallationSearchFormState extends State<InstallationSearchForm> {
  final TextEditingController _imeiController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  final List<String> _jobCategories = [
    "Mới tạo",
    "Đã lắp xong",
    "Cần cập nhật",
    "Đã cập nhật"
  ];
  List<String> _selectedJobCategories = [];

  String _getSelectedJobs() {
    if (_selectedJobCategories.isEmpty) {
      return '';
    }
    return _selectedJobCategories.join(",");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _imeiController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Số xe/ Số imei",
                prefixIcon: Icon(
                  Icons.directions_car_filled,
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _fromDateController,
            readOnly: true,
            onTap: () {
              selectedDate(context, _fromDateController);
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Từ ngày",
                prefixIcon: Icon(
                  Icons.calendar_month_sharp,
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _toDateController,
            readOnly: true,
            onTap: () {
              selectedDate(context, _toDateController);
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Đến ngày",
                prefixIcon: Icon(
                  Icons.calendar_month_sharp,
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            readOnly: true,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CategoriesSearch(
                        categoriesList: _jobCategories,
                        selectedCategories: _selectedJobCategories,
                        onSelectionChanged: (selected) {
                          setState(() {
                            _selectedJobCategories = selected;
                          });
                        });
                  });
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: _selectedJobCategories.isEmpty
                    ? "Trạng thái job"
                    : _selectedJobCategories.join(", "),
                // Hiển thị trạng thái đã chọn
                suffixIcon: const Icon(Icons.arrow_drop_down)),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      setState(() {
                        _imeiController.clear();
                        _fromDateController.clear();
                        _toDateController.clear();
                      });
                    },
                    child: const Text(
                      "Xóa điều kiện",
                    )),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onSearch(
                        _imeiController.text.trim(),
                        _fromDateController.text.trim(),
                        _toDateController.text.trim(),
                        _getSelectedJobs()
                      );
                    },
                    child: const Text(
                      "Tìm kiếm",
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
