import 'package:dio/dio.dart';
import '../models/detailed_installation.dart';
import '../models/job.dart';
import 'base_service.dart';

class JobService extends BaseService {
  Future<JobResponse> getJob({
    int page = 1,
    int size = 10,
    String? search,
    String? status,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      Map<String, dynamic> queryParams = {
        'page': page,
        'size': size,
        'search': search,
        'status': status,
        'from_date': fromDate,
        'to_date': toDate,
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
}
