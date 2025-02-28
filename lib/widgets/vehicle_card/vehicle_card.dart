import 'package:flutter/material.dart';
import 'package:iov_app/screens/detailed_installation/detailed_installation.dart';

class VehicleCard extends StatelessWidget {
  final Map<String, String> item;
  const VehicleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const DetailedInstallation()));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                item['image']!,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item['subtitle']!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      item['status']!,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
