import 'package:flutter/material.dart';

class CategoriesSearch extends StatefulWidget {
  const CategoriesSearch({super.key});

  @override
  State<CategoriesSearch> createState() => _CategoriesSearchState();
}

class _CategoriesSearchState extends State<CategoriesSearch> {
  bool _moiTaoChecked = false;
  bool _daLapXongChecked = false;
  bool _canCapNhatChecked = false;
  bool _daCapNhatChecked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView( // Để tránh tràn màn hình
        child: Column(
          mainAxisSize: MainAxisSize.min, // Quan trọng để chiều cao dialog vừa nội dung
          children: [
            // Ô Tìm kiếm (ví dụ đơn giản)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade600),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm',
                        border: InputBorder.none, // Loại bỏ border của TextField
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Checkboxes
            CheckboxListTile(
              title: const Text('Mới tạo'),
              value: _moiTaoChecked,
              onChanged: (bool? value) {
                setState(() {
                  _moiTaoChecked = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading, // Checkbox bên trái
            ),
            CheckboxListTile(
              title: const Text('Đã lắp xong'),
              value: _daLapXongChecked,
              onChanged: (bool? value) {
                setState(() {
                  _daLapXongChecked = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Cần cập nhật'),
              value: _canCapNhatChecked,
              onChanged: (bool? value) {
                setState(() {
                  _canCapNhatChecked = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Đã cập nhật'),
              value: _daCapNhatChecked,
              onChanged: (bool? value) {
                setState(() {
                  _daCapNhatChecked = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),

            const Divider(),

            // Các button ở dưới
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Xử lý chọn tất cả
                      setState(() {
                        _moiTaoChecked = true;
                        _daLapXongChecked = true;
                        _canCapNhatChecked = true;
                        _daCapNhatChecked = true;
                      });
                    },
                    child: const Text('Chọn tất cả', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Đóng dialog
                    },
                    child: const Text('Hoàn thành', style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}