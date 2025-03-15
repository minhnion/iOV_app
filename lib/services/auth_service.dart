import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_service.dart';

class AuthService extends BaseService {
  Future<bool> registerDevice() async {
    try {
      String deviceId = 'test_device_id_01';
      String deviceName = 'test_device_name_01';
      String deviceToken = 'test_device_token_01';

      final response = await dio.post(
        '/device/register-token',
        data: {
          'device_id': deviceId,
          'device_name': deviceName,
          'device_token': deviceToken
        },
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('device_id', deviceId);
        await prefs.setString('device_name', deviceName);
        await prefs.setString('device_token', deviceToken);
        return true;
      }
      return false;
    } catch (e) {
      print('Register device error: $e');
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString('device_id');
      String? deviceName = prefs.getString('device_name');
      String? deviceToken = prefs.getString('device_token');

      final requestData = {
        'username': username,
        'password': password,
      };

      final response = await dio.post(
        '/auth/login-mobile',
        data: requestData,
        options: Options(
          headers: {
            'Device-Id': deviceId,
            'Device-Name': deviceName,
            'Device-Token': deviceToken,
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        await saveToken(data['access_token'], data['refresh_token']);
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<void> logout() async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('accessToken');
      prefs.remove('refreshToken');
      prefs.remove('device_id');
      prefs.remove('device_name');
      prefs.remove('device_token');
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> decodeAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    if(accessToken!=null){
      Map<String,dynamic> decodedToken = JwtDecoder.decode(accessToken);
      print(decodedToken);
      prefs.setString('userName', decodedToken['user_name']);
      prefs.setString('fullName', decodedToken['full_name']);
      prefs.setString('roleName', decodedToken['role_name']);
      prefs.setString('phoneNumber', decodedToken['phone_number']);
      prefs.setString('address', decodedToken['address']);
      prefs.setString('email', decodedToken['email']);
      prefs.setString('gender', decodedToken['gender']);
      prefs.setString('dateOfBirth', decodedToken['date_of_birth']);
    }
  }
}
