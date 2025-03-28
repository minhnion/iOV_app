import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
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

  void updateDeletedImagePath(String fieldName, List<String> deletedImagePaths) {
    setState(() {
      updatedFields[fieldName] = deletedImagePaths.toList();
    });
  }

  Future<void> saveChanges() async {
    if (updatedFields.isEmpty) return;
    print('111');
    print(updatedFields);
    //call api
    try {
      await JobService().updateInstallation(widget.jobId, updatedFields);
    } catch (e) {
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
                      label: "installation_type".tr(),
                      initialValue: detailed.installationType ?? '',
                      isEditable: isEdit, 
                      onValueChanged: (value) {
                        updateFieldValue('installation_type', value);
                      },
                    ),
                    IconField(
                      label: 'note'.tr(),
                      keyField: "note",
                      initialValue: detailed.note ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('note', value);
                      },
                    ),
                    IconField(
                      label: "installation_date".tr(),
                      icon: Icons.calendar_today,
                      keyField: 'date',
                      initialValue: detailed.installationDate ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('installation_date', value);
                      },
                    ),
                    IconField(
                      label: "installation_location".tr(),
                      icon: Icons.location_on,
                      keyField: 'location',
                      initialValue: detailed.installationLocation ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('installation_location', value);
                      },
                    ),
                    IconField(
                      label: "odo_km".tr(),
                      keyField: "odo",
                      initialValue: detailed.odometerReading ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('odometer_reading', value);
                      },
                    ),
                    ImageCameraField(
                      label: 'vehicle_info_photo'.tr(),
                      imagePaths: detailed.vehicleInforImgPaths ?? [],
                      isEditable: isEdit,
                      fieldName: 'vehicle_infor_img_files',
                      onFilesChanged: updateFileValue,
                      onDeletedImagesChanged: (value) {
                        updateFieldValue('vehicle_infor_img_del_paths', value);
                      },
                    ),
                    ImageCameraField(
                      label: 'device_sim_photo'.tr(),
                      imagePaths: detailed.deviceAndSimImgPaths ?? [],
                      isEditable: isEdit,
                      fieldName: 'device_and_sim_img_files',
                      onFilesChanged: updateFileValue,
                      onDeletedImagesChanged: (value) {
                        updateFieldValue('device_and_sim_img_del_paths', value);
                      },
                    ),
                    ImageCameraField(
                      label: 'installation_photo'.tr(),
                      imagePaths: detailed.installationImgPaths ?? [],
                      isEditable: isEdit,
                      fieldName: 'installation_img_files',
                      onFilesChanged: updateFileValue,
                      onDeletedImagesChanged: (value) {
                        updateFieldValue('installation_img_del_paths', value);
                      },
                    ),
                    ImageCameraField(
                      label: 'device_after_install_photo'.tr(),
                      imagePaths: detailed.afterInstallationImgPaths ?? [],
                      isEditable: isEdit,
                      fieldName: 'after_installation_img_files',
                      onFilesChanged: updateFileValue,
                      onDeletedImagesChanged: (value) {
                        updateFieldValue('after_installation_img_del_paths', value);
                      },
                    ),
                    ImageCameraField(
                      label: 'device_status_photo'.tr(),
                      imagePaths: detailed.deviceStatusImgPaths ?? [],
                      isEditable: isEdit,
                      onFilesChanged: updateFileValue,
                      fieldName: 'device_status_img_files',
                      onDeletedImagesChanged: (value) {
                        updateFieldValue('device_status_img_del_paths', value);
                      },
                    ),
                    IconField(
                      label: "sim_number".tr(),
                      icon: Icons.document_scanner_outlined,
                      keyField: 'barcode',
                      initialValue: detailed.simNo ?? '',
                      isEditable: isEdit,
                      onValueChanged: (value) {
                        updateFieldValue('sim_no', value);
                      },
                    ),
                    IconField(
                      label: "imei_number".tr(),
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
                  child: Text(
                    'cancel'.tr(),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    saveChanges();
                    setState(() {
                      isEdit = false;
                    });
                  },
                  child: Text(
                    'save_button'.tr(),
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
              ]
                  : [
                TextButton(
                  onPressed: toggleEditMode,
                  child: Text(
                    'edit_button_label'.tr(),
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    fulfillInstallation();
                  },
                  child: Text(
                    'done'.tr(),
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
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
