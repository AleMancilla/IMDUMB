import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import 'dio_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
          ),
        ) {
    dio.interceptors.add(AppDioInterceptor());
  }
}