class Job {
  final String ?imei_no;
  final String ?installation_date;
  final String ?installation_location;
  final int ?job_id;
  final String ?job_status;
  final String ?model;
  final String ?segment_img;
  final String ?vin_no;

  Job({
    this.imei_no,
    this.installation_date,
    this.installation_location,
    this.job_id,
    this.job_status,
    this.model,
    this.segment_img,
    this.vin_no,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      imei_no: json['imei_no'],
      installation_date: json['installation_date'],
      installation_location: json['installation_location'],
      job_id: json['job_id'],
      job_status: json['job_status'],
      model: json['model'],
      segment_img: json['segment_img'],
      vin_no: json['vin_no'],
    );
  }
}

class JobResponse {
  final List<Job> jobs;
  final int totalRecords;

  JobResponse({required this.jobs, required this.totalRecords});

  factory JobResponse.fromJson(Map<String, dynamic> json) {
    return JobResponse(
      jobs: (json['jobs'] as List).map((job) => Job.fromJson(job)).toList(),
      totalRecords: json['total_records'] ?? 0,
    );
  }
}
