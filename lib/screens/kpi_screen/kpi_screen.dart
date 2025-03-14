import 'package:flutter/material.dart';
import 'package:iov_app/models/kpi.dart';
import 'package:iov_app/services/kpi_service.dart';
import 'package:iov_app/widgets/kpi_card/kpi_per_month_card.dart';
import 'package:iov_app/widgets/menu_tab/menu_tab.dart';

import '../../widgets/kpi_card/kpi_general_card.dart';

class KpiScreen extends StatefulWidget {
  const KpiScreen({super.key});

  @override
  State<KpiScreen> createState() => _KpiScreenState();
}

class _KpiScreenState extends State<KpiScreen> {
  bool isLoading = true;
  late KpiData kpis;

  Future<void> fetchKpi() async {
    setState(() {
      isLoading = true;
    });
    try {
      KpiData result = await KpiService().getKpi();
      setState(() {
        kpis = result;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    fetchKpi();
  }

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
            onPressed: () {
              fetchKpi();
            },
          ),
        ],
      ),
      drawer: MenuTab(
        selectedMenu: "Kpi",
        onLanguageChanged: () {
          setState(() {});
        },
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : Padding(
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
                          value: "${kpis.actualDaily}/${kpis.planDaily}",
                          icon: Icons.library_books_sharp,
                          color: Colors.blue.shade100,
                          iconColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: KpiGeneralCard(
                          title: "KPI hàng tháng",
                          value: "${kpis.actualMonthly}/${kpis.planMonthly}",
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
                  ...kpis.kpi3Months.map((item) => KpiPerMonthCard(
                        item: item,
                      ))
                ],
              ),
            ),
    );
  }
}
