class DetailedInstallation {
  final int ?jobId;
  final String ?vinNo;
  final String ?engineNo;
  final String ?installationType;
  final String ?installationDate;
  final String ?installationLocation;
  final String ?odometerReading;
  final String ?note;
  final String ?simNo;
  final String ?imeiNo;
  final String ?jobStatus;
  final String ?lotNo;
  final String ?manufactureDate;
  final String ?model;
  final String ?segment;
  final String ?specialEquipment;
  final List<String> ?vehicleInforImgPaths;
  final List<String> ?deviceAndSimImgPaths;
  final List<String> ?installationImgPaths;
  final List<String> ?afterInstallationImgPaths;
  final List<String> ?deviceStatusImgPaths;

  DetailedInstallation({
    this.jobId,
    this.vinNo,
    this.engineNo,
    this.installationType,
    this.installationDate,
    this.installationLocation,
    this.odometerReading,
    this.note,
    this.simNo,
    this.imeiNo,
    this.jobStatus,
    this.lotNo,
    this.manufactureDate,
    this.model,
    this.segment,
    this.specialEquipment,
    this.vehicleInforImgPaths,
    this.deviceAndSimImgPaths,
    this.installationImgPaths,
    this.afterInstallationImgPaths,
    this.deviceStatusImgPaths,
  });

  factory DetailedInstallation.fromJson(Map<String, dynamic> json) {
    return DetailedInstallation(
      jobId: json['job_id'],
      vinNo: json['vin_no'],
      engineNo: json['engine_no'],
      installationType: json['installation_type'],
      installationDate: json['installation_date'],
      installationLocation: json['installation_location'],
      odometerReading: json['odometer_reading'],
      note: json['note'],
      simNo: json['sim_no'],
      imeiNo: json['imei_no'],
      jobStatus: json['job_status'],
      lotNo: json['lot_no'],
      manufactureDate: json['manufacture_date'],
      model: json['model'],
      segment: json['segment'],
      specialEquipment: json['special_equipment'],
      vehicleInforImgPaths: List<String>.from(json['vehicle_infor_img_paths']),
      deviceAndSimImgPaths: List<String>.from(json['device_and_sim_img_paths']),
      installationImgPaths: List<String>.from(json['installation_img_paths']),
      afterInstallationImgPaths: List<String>.from(json['after_installation_img_paths']),
      deviceStatusImgPaths: List<String>.from(json['device_status_img_paths']),
    );
  }
}