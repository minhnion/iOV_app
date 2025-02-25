import 'package:flutter/material.dart';
import 'package:iov_app/widgets/kpi_card/kpi_per_month_card.dart';
import 'package:iov_app/widgets/menu_tab/menu_tab.dart';

import '../../widgets/kpi_card/kpi_general_card.dart';

class KpiScreen extends StatefulWidget {
  const KpiScreen({super.key});

  @override
  State<KpiScreen> createState() => _KpiScreenState();
}

class _KpiScreenState extends State<KpiScreen> {

  // Dữ liệu mẫu cho danh sách cài đặt
  List<Map<String, String>> kpisPerMonth = [
    {
      'time': 'Thang 1 - 2025',
      'planned': '0',
      'actual': '0',
    },
    {
      'time': 'Thang 12 - 2024',
      'planned': '0',
      'actual': '0',
    },
    {
      'time': 'Thang 11 - 2024',
      'planned': '0',
      'actual': '0',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: MenuTab(selectedMenu: "Kpi", onLanguageChanged: () {
        setState(() {

        });
      },),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tổng quan",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: KpiGeneralCard(
                    title: "KPI hàng ngày",
                    value: "0 / 0",
                    icon: Icons.library_books_sharp,
                    color: Colors.blue.shade100,
                    iconColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: KpiGeneralCard(
                    title: "KPI hàng tháng",
                    value: "25 / 29",
                    icon: Icons.stacked_bar_chart_outlined,
                    color: Colors.lightGreen.shade100,
                    iconColor: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Chi tiết KPI (3 tháng gần nhất)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...kpisPerMonth.map((item) => KpiPerMonthCard(item: item,))
          ],
        ),
      ),
    );
  }

}