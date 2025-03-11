import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api-mobile.hino-connect.vn/iov-app-api/v1',
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    headers: {'Content-Type': 'application/json'},
  ));

  Dio get dio => _dio;

  BaseService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.path != '/auth/login-mobile' && options.path != '/device/register-token') {
          await _refreshAccessToken();
          String? accessToken = await _getAccessToken();
          if (accessToken != null && accessToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
        }

        print('Request URL: ${options.path}');
        print('Request Headers: ${options.headers}');
        print('Request Data: ${options.data}');

        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response Status: ${response.statusCode}');
        print('Response Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('Error Status: ${e.response?.statusCode}');
        print('Error Data: ${e.response?.data}');
        return handler.next(e);
      },
    ));
  }

  // get accessToken from local
  Future<String?> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // store accessToken
  @protected
  Future<void> saveToken(String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  // Refresh accessToken
  Future<void> _refreshAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refreshToken');

    try {
      final response = await _dio.post('/auth/refresh-token',
          options: Options(headers: {'Authorization': 'Bearer $refreshToken'}));

      if (response.statusCode == 200) {
        String newAccessToken = response.data['data']['access_token'];
        await saveToken(newAccessToken, refreshToken!);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // GET request
  Future<Response?> getRequest(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // POST request
  Future<Response?> postRequest(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
