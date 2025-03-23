import 'dart:io';

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
  State<DetailedInstallationScreen> createState() =>
      _DetailedInstallationScreenState();
}

class _DetailedInstallationScreenState
    extends State<DetailedInstallationScreen> {
  bool isLoading = true;
  bool isEdit = false;
  late DetailedInstallation detailed;
  Map<String, dynamic> updatedFields = {};

  Future<void> fetchDetailedInstallation() async {
    try {
      final data = await JobService().getDetailedInstallation(widget.jobId);
      setState(() {
        isLoading = false;
        detailed = data!;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void toggleEditMode() {
    if(detailed.jobStatus!= "Finished Installation") {
      setState(() {
        isEdit = ! isEdit;
      });
    }else {
      print("Cannot edit");
    }
  }
  
  void updateFieldValue(String fieldName, dynamic value) {
    setState(() {
      updatedFields[fieldName] = value;
    });
  }

  void updateFileValue(String fieldName, List<File> files) {
    setState(() {
      updatedFields[fieldName] = files;  // Lưu trực tiếp danh sách File vào updatedFields
    });
  }
  
  Future<void> saveChanges() async {
    if(updatedFields.isEmpty) return;
    print('111');
    print(updatedFields);
    //call api
    try{
      await JobService().updateInstallation(widget.jobId, updatedFields);
    }catch(e){
      print('Error: $e');
    }
  }

  Future<void> fulfillInstallation() async {
    try{
      await JobService().finishInstallation(widget.jobId);
    }catch(e){
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
        title: isLoading
            ? const Text('...')
            : Text(
                detailed.vinNo ?? '',
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
                      isEditable: isEdit, 
                      onValueChanged: (value) {
                        updateFieldValue('installation_type', value);
                      },
                    ),
                    IconField(
                      label: 'Ghi chú',
                      keyField: "note",
                      initialValue: detailed.note ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('note', value);
                      },
                    ),
                    IconField(
                      label: "Ngày cài đặt",
                      icon: Icons.calendar_today,
                      keyField: 'date',
                      initialValue: detailed.installationDate ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('installation_date', value);
                      },
                    ),
                    IconField(
                      label: "Vị trí cài đặt",
                      icon: Icons.location_on,
                      keyField: 'location',
                      initialValue: detailed.installationLocation ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('installation_location', value);
                      },
                    ),
                    IconField(
                      label: "ODO (km)",
                      keyField: "odo",
                      initialValue: detailed.odometerReading ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('odometer_reading', value);
                      },
                    ),
                    ImageCameraField(
                      label: 'Ảnh thông tin xe',
                      imagePaths: detailed.vehicleInforImgPaths ?? [],
                      isEditable: isEdit,
                      fieldName: 'vehicle_infor_img_file',
                      onFilesChanged: updateFileValue,
                    ),
                    ImageCameraField(
                      label: 'Ảnh thiết bị và sim',
                      imagePaths: detailed.deviceAndSimImgPaths ?? [],
                      isEditable: isEdit,
                      fieldName: '',
                      onFilesChanged: updateFileValue,
                    ),
                    ImageCameraField(
                      label: 'Ảnh lắp đặt',
                      imagePaths: detailed.installationImgPaths ?? [],
                      isEditable: isEdit,
                      fieldName: '',
                      onFilesChanged: updateFileValue,
                    ),
                    ImageCameraField(
                      label: 'Ảnh thiết bị sau lắp đặt',
                      imagePaths: detailed.afterInstallationImgPaths ?? [],
                      isEditable: isEdit,
                      fieldName: 'after_installation_img_file',
                      onFilesChanged: updateFileValue,
                    ),
                    ImageCameraField(
                      label: 'Ảnh trạng thái thiết bị',
                      imagePaths: detailed.deviceStatusImgPaths ?? [],
                      isEditable: isEdit,
                      onFilesChanged: updateFileValue,
                      fieldName: '',
                    ),
                    IconField(
                      label: "Số sim",
                      icon: Icons.document_scanner_outlined,
                      keyField: 'barcode',
                      initialValue: detailed.simNo ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('sim_no', value);
                      },
                    ),
                    IconField(
                      label: "Số imei",
                      icon: Icons.document_scanner_outlined,
                      keyField: 'barcode',
                      initialValue: detailed.imeiNo ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('imei_no', value);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black, width: 0.7),
          ),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: isEdit
                  ? [
                TextButton(
                  onPressed: () {
                    setState(() {
                      updatedFields.clear();
                      isEdit = false;
                    });
                  },
                  child: const Text(
                    'Hủy',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    saveChanges();
                    setState(() {
                      isEdit = false;
                    });
                  },
                  child: const Text(
                    'Lưu',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
              ]
                  : [
                TextButton(
                  onPressed: toggleEditMode,
                  child: const Text(
                    'Chỉnh sửa',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    fulfillInstallation();
                  },
                  child: const Text(
                    'Hoàn thành',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
