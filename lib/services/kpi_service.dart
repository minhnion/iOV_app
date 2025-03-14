import 'package:dio/dio.dart';
import 'package:iov_app/models/kpi.dart';
import 'package:iov_app/services/base_service.dart';

class KpiService extends BaseService{
  Future<KpiData> getKpi() async{
    try{
      Response? response = await getRequest('/report/technician-kpi');
      if(response != null && response.statusCode ==200){
        return KpiData.fromJson(response.data);
      }
    }catch(e){
      print('Error fetching Kpi: $e');
    }
    return KpiData(
        actualDaily: 0,
        actualMonthly: 0,
        planDaily: 0,
        planMonthly: 0,
        kpi3Months: []);
  }
}