import 'package:flutter/material.dart';

class KpiPerMonthCard extends StatelessWidget {
  final Map<String, String> item;

  const KpiPerMonthCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,10),
      child: Container(
        decoration: BoxDecoration(
          color:  const Color.fromRGBO(237, 237, 240, 100),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Màu của bóng
              spreadRadius: 2, // Độ lan tỏa của bóng
              blurRadius: 3, // Độ mờ của bóng
              offset: const Offset(0, 3), // Vị trí bóng (x, y)
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.bar_chart, color: Colors.blue,),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["time"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Kế hoạch: ${item["planned"]!} | Thực tế: ${item["actual"]!}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}