import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iov_app/widgets/installation_search_form/installation_search_form.dart';
import 'package:iov_app/widgets/menu_tab/menu_tab.dart';
import 'package:iov_app/widgets/vehicle_card/vehicle_card.dart';

class InstallationsScreen extends StatefulWidget {
  const InstallationsScreen({super.key});

  @override
  State<InstallationsScreen> createState() => _InstallationsScreenState();
}

class _InstallationsScreenState extends State<InstallationsScreen> {

  // Dữ liệu mẫu cho danh sách cài đặt
  final List<Map<String, String>> installations = [
    {
      'image': 'assets/img/xzu_logo.png',
      'title': 'RNJYCS0F8S4102558',
      'subtitle': 'XZU720L-WKFRS3',
      'status': 'Đã lắp xong',
    },
    {
      'image': 'assets/img/xzu_logo.png',
      'title': 'RNJYCS0F6S4102560',
      'subtitle': 'XZU720L-WKFRS3',
      'status': 'Đã cập nhật',
    },
    {
      'image': 'assets/img/fg_logo.png',
      'title': 'RNJFG8JT8SXX10190',
      'subtitle': 'FG8JT8A-PGX',
      'status': 'Đã lắp xong',
    },
    {
      'image': 'assets/img/xzu_logo.png',
      'title': 'RNJYCS0FXS4102562',
      'subtitle': 'XZU720L-WKFRS3',
      'status': 'Đã lắp xong',
    },
    {
      'image': 'assets/img/xzu_logo.png',
      'title': 'RNJYCS0F8S4102561',
      'subtitle': 'XZU720L-WKFRS3',
      'status': 'Đã lắp xong',
    },
    {
      'image': 'assets/img/xzu_logo.png',
      'title': 'RNJYCS0FXS4102559',
      'subtitle': 'XZU720L-WKFRS3',
      'status': 'Đã lắp xong',
    },
    {
      'image': 'assets/img/xzu_logo.png',
      'title': 'RNJYCS0F1S4102563',
      'subtitle': 'XZU720L-WKFRS3',
      'status': 'Đã lắp xong',
    },
    {
      'image': 'assets/img/xzu_logo.png',
      'title': 'RNJYCS0F8S4102558',
      'subtitle': 'XZU720L-WKFRS3',
      'status': 'Đã cập nhật',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(193, 234, 193, 100),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 240, 2, 100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'iOV',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Installations',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context){
                    return const InstallationSearchForm();
                  }
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const MenuTab(selectedMenu: "Installations"),
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey,
                child: Text(installations.length.toString()),
              )
            ],
          ),
          ...installations.map((item) => VehicleCard(item: item)),
        ],
      ),
    );
  }

}