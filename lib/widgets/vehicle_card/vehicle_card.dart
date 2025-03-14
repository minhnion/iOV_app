import 'package:flutter/material.dart';
import 'package:iov_app/screens/detailed_installation/detailed_installation.dart';

import '../../models/job.dart';

class VehicleCard extends StatelessWidget {
  final Job item;
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
              Image.network(
                item.segment_img!,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.vin_no??"Null",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.model??"Null",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      item.job_status??"Null",
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
