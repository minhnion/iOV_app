import 'package:flutter/material.dart';
import 'package:iov_app/widgets/categories_search/categories_search.dart';

class InstallationSearchForm extends StatefulWidget {
  const InstallationSearchForm({super.key});

  @override
  State<InstallationSearchForm> createState() => _InstallationSearchFormState();
}

class _InstallationSearchFormState extends State<InstallationSearchForm> {
  final TextEditingController _imeiController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _jobStatus = TextEditingController();

  Future<void> _selectedDate(BuildContext context, TextEditingController controller) async{
    DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("vi","VN"),
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );
    if(picked!=null){
      setState(() {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
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
              prefixIcon: Icon(Icons.directions_car_filled,)
            ),
          ),
          const SizedBox(height: 16,),
          TextFormField(
            controller: _fromDateController,
            readOnly: true,
            onTap: (){
              _selectedDate(context, _fromDateController);
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Từ ngày",
                prefixIcon: Icon(Icons.calendar_month_sharp,)
            ),
          ),
          const SizedBox(height: 16,),
          TextFormField(
            controller: _toDateController,
            readOnly: true,
            onTap: (){
              _selectedDate(context, _toDateController);
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Đến ngày",
                prefixIcon: Icon(Icons.calendar_month_sharp,)
            ),
          ),
          const SizedBox(height: 16,),
          TextFormField(
            readOnly: true,
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return const CategoriesSearch();
                  }
              );
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Trạng thái job",
              suffixIcon: Icon(Icons.arrow_drop_down)
            ),
          ),
          const SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    onPressed: (){
                      setState(() {
                        _imeiController.clear();
                        _fromDateController.clear();
                        _toDateController.clear();
                      });
                    }, 
                    child: const Text(
                      "Xóa điều kiện",
                    )
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    onPressed: (){
                      
                    }, 
                    child: const Text(
                      "Tìm kiếm",
                    )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
