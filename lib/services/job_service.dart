import 'package:dio/dio.dart';
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
        if (search != null && search.isNotEmpty) 'search': search,
        if (status != null && status.isNotEmpty) 'status': status,
        if (fromDate != null && fromDate.isNotEmpty) 'from_date': fromDate,
        if (toDate != null && toDate.isNotEmpty) 'to_date': toDate,
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
}
