import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iov_app/widgets/categories_search/categories_search.dart';

import '../../utils/date_picker.dart';

class InstallationSearchForm extends StatefulWidget {
  final Function(String imeiNumber, String fromDate, String toDate, String status) onSearch;
  final String? initialImei;
  final String? initialFromDate;
  final String? initialToDate;
  final List<String>? initialSelectedCategories;

  const InstallationSearchForm(
      {super.key,
      required this.onSearch,
      this.initialImei,
      this.initialFromDate,
      this.initialToDate,
      this.initialSelectedCategories});

  @override
  State<InstallationSearchForm> createState() => _InstallationSearchFormState();
}

class _InstallationSearchFormState extends State<InstallationSearchForm> {
  late TextEditingController _imeiController = TextEditingController();
  late TextEditingController _fromDateController = TextEditingController();
  late TextEditingController _toDateController = TextEditingController();

  final List<String> _jobCategories = [
    "new".tr(),
    "finished_installation".tr(),
    "need_update_status".tr(),
    "updated_status".tr()
  ];
  List<String> _selectedJobCategories = [];

  String _getSelectedJobs() {
    if (_selectedJobCategories.isEmpty) {
      return '';
    }
    return _selectedJobCategories.join(",");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imeiController = TextEditingController(text: widget.initialImei ?? '');
    _fromDateController = TextEditingController(text: widget.initialFromDate ?? '');
    _toDateController = TextEditingController(text: widget.initialToDate ?? '');
    _selectedJobCategories = widget.initialSelectedCategories ?? [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _imeiController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
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
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "vehicle_imei_number".tr(),
                prefixIcon: const Icon(
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
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "from_date".tr(),
                prefixIcon: const Icon(
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
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "to_date".tr(),
                prefixIcon: const Icon(
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
                    ? "job_status".tr()
                    : _selectedJobCategories.join(", "),
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
                    child: Text(
                      "clear_filter".tr(),
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
                    child: Text(
                      "search".tr(),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
