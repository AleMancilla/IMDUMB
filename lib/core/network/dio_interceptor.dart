import 'dart:developer';

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class AppDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters = {
      ...options.queryParameters,
    };

    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ApiConstants.apiKey}',

    });

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('❌ ERROR: ${err.requestOptions.uri}');
    log('❌ MESSAGE: ${err.message}');
    log('❌ RESPONSE: ${err.response?.data}');
    handler.next(err);
  }
}
