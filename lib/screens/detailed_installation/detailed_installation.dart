import 'package:flutter/material.dart';
import 'package:iov_app/services/job_service.dart';
import 'package:iov_app/widgets/detailed_installation_form_field/icon_field.dart';
import 'package:iov_app/widgets/detailed_installation_form_field/image_camera_field.dart';
import 'package:iov_app/widgets/detailed_installation_form_field/selection_filed.dart';

import '../../models/detailed_installation.dart';


class DetailedInstallationScreen extends StatefulWidget {
  const DetailedInstallationScreen({super.key, required this.jobId});
  final int jobId;
  @override
  State<DetailedInstallationScreen> createState() => _DetailedInstallationScreenState();
}

class _DetailedInstallationScreenState extends State<DetailedInstallationScreen> {
  bool isLoading = true;
  late DetailedInstallation detailed;

  Future<void> fetchDetailedInstallation() async {
    try{
      print('111');
      final data = await JobService().getDetailedInstallation(widget.jobId);
      print(222);
      setState(() {
        isLoading = false;
        detailed = data!;
      });
    }catch(e){
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetailedInstallation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(193, 234, 193, 100),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: isLoading? const Text('...'):
        Text(
          detailed.vinNo?? '',
          style: const TextStyle(color: Colors.black),
        ),

      ),
      body: isLoading
          ? const Center(
            child: CircularProgressIndicator(
                color: Colors.black,
              ),
          )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectionFiled(
                      label: "Loại cài đặt",
                      initialValue: detailed.installationType ?? '',
                    ),
                    IconField(
                      label: 'Ghi chú',
                      keyField: "note",
                      initialValue: detailed.note??'',
                    ),
                    IconField(
                      label: "Ngày cài đặt",
                      icon: Icons.calendar_today,
                      keyField: 'date',
                      initialValue: detailed.installationDate??'',
                    ),
                    IconField(
                      label: "Vị trí cài đặt",
                      icon: Icons.location_on,
                      keyField: 'location',
                      initialValue: detailed.installationLocation??'',
                    ),
                    IconField(
                      label: "ODO (km)",
                      keyField: "odo",
                      initialValue: detailed.odometerReading??'',
                    ),
                    ImageCameraField(
                      label: 'Ảnh thông tin xe',
                      imagePaths: detailed.vehicleInforImgPaths??[],
                    ),
                    const ImageCameraField(label: 'Ảnh thiết bị và sim'),
                    const ImageCameraField(label: 'Ảnh lắp đặt'),
                    const ImageCameraField(label: 'Ảnh thiết bị sau lắp đặt'),
                    const ImageCameraField(label: 'Ảnh trạng thái thiết bị'),
                    IconField(
                      label: "Số sim",
                      icon: Icons.document_scanner_outlined,
                      keyField: 'barcode',
                      initialValue: detailed.simNo??'',
                    ),
                    IconField(
                      label: "Số imei",
                      icon: Icons.document_scanner_outlined,
                      keyField: 'barcode',
                      initialValue: detailed.imeiNo??'',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black,width: 0.5)
          )
        ),
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    // Handle edit action
                  },
                  child: const Text('Chỉnh sửa', style: TextStyle(fontSize: 16)),
                ),
                InkWell(
                  onTap: () {
                    // Handle complete action
                  },
                  child: const Text('Hoàn thành', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}