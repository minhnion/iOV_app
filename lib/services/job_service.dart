import 'dart:io';

import 'package:dio/dio.dart';
import '../models/detailed_installation.dart';
import '../models/job.dart';
import 'base_service.dart';

class JobService extends BaseService {
  Future<JobResponse> getJob({
    int page = 1,
    int size = 10,
    String? search,
    List<String>? status,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      Map<String, dynamic> queryParams = {
        'page': page,
        'size': size,
        'search': search,
        'from_date': fromDate,
        'to_date': toDate,
        if (status != null && status.isNotEmpty)
          'status': status.join(','),
      };
      Response? response = await getRequest('/job/search', queryParams: queryParams);

      if (response != null && response.statusCode == 200) {
        return JobResponse.fromJson(response.data['data']);
      }
    } catch (e) {
      print('Error fetching jobs: $e');
    }
    return JobResponse(jobs: [], totalRecords: 0);
  }

  Future<DetailedInstallation?> getDetailedInstallation(int jobId) async {
    try{
      final response = await getRequest('/job/$jobId');
      if(response!=null && response.statusCode == 200) {
        return DetailedInstallation.fromJson(response.data['data']);
      }
    }catch(e){
      throw Exception('Error: $e');
    }
    return null;
  }

  Future<void> updateInstallation(int jobId, Map<String, dynamic> updates) async{
    final Map<String, dynamic> formDataMap = {};

    for (final entry in updates.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is File) {
        // Nếu là một file, chuyển thành MultipartFile
        formDataMap[key] = await MultipartFile.fromFile(
          value.path,
          filename: value.path.split('/').last,
        );
      } else if (value is List<File>) {
        // Nếu là danh sách File, chuyển tất cả sang MultipartFile
        formDataMap[key] = await Future.wait(
          value.map((file) async => await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          )),
        );
      } else {
        // Các trường khác giữ nguyên
        formDataMap[key] = value;
      }
    }

    final formData = FormData.fromMap(formDataMap);

    try{
      await postRequest('/job/update/$jobId', data: formData);
    }catch(e){
      throw Exception('Error: $e');
    }
  }

  Future<void> finishInstallation(int jobId) async{
    try{
      await postRequest('/job/finish-installation/$jobId');
    }catch(e){
      throw Exception('Error: $e');
    }
  }
}

