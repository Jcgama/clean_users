import 'package:dio/dio.dart';

class ApiClient {
  Dio getDio() {
    final dio = Dio();
    dio.options.baseUrl = 'https://dummyjson.com/';
    return dio;
  }
}