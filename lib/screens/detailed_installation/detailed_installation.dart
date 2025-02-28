import 'package:flutter/material.dart';
import 'package:iov_app/widgets/detailed_installation_form_field/icon_field.dart';
import 'package:iov_app/widgets/detailed_installation_form_field/image_camera_field.dart';
import 'package:iov_app/widgets/detailed_installation_form_field/selection_filed.dart';
import 'package:iov_app/widgets/detailed_installation_form_field/text_type_field.dart';


class DetailedInstallation extends StatefulWidget {
  const DetailedInstallation({super.key});
  @override
  State<DetailedInstallation> createState() => _DetailedInstallationState();
}

class _DetailedInstallationState extends State<DetailedInstallation> {


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
        title: const Text(
          'RNJYCS0F8S4102558',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectionFiled(label: "Loại cài đặt"),
              TextTypeField(label: 'Ghi chú'),
              IconField(label: "Ngày cài đặt", icon: Icons.calendar_today, keyField: 'date',),
              IconField(label: "Vị trí cài đặt", icon: Icons.location_on, keyField: 'location',),
              TextTypeField(label: "ODO (km)"),
              ImageCameraField(label: 'Ảnh thông tin xe'),
              ImageCameraField(label: 'Ảnh thiết bị và sim'),
              ImageCameraField(label: 'Ảnh lắp đặt'),
              ImageCameraField(label: 'Ảnh thiết bị sau lắp đặt'),
              ImageCameraField(label: 'Ảnh trạng thái thiết bị'),
              IconField(label: "Số sim", icon: Icons.document_scanner_outlined, keyField: 'scan',),
              IconField(label: "Số imei", icon: Icons.document_scanner_outlined, keyField: 'scan',),
              SizedBox(height: 20),
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