import 'dart:convert';
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

    log(
      '📋 cURL ============================================\n${_buildCurl(options)}\n____________________________________________',
    );
    handler.next(options);
  }

  String _buildCurl(RequestOptions options) {
    final buffer = StringBuffer();
    buffer.write("curl -X ${options.method}");
    buffer.write(" '${options.uri}'");
    for (final entry in options.headers.entries) {
      final value = entry.value;
      if (value != null) {
        buffer.write(" \\\n  -H '${entry.key}: $value'");
      }
    }
    if (options.data != null) {
      final data = options.data is String
          ? options.data as String
          : jsonEncode(options.data);
      buffer.write(" \\\n  --data-raw '$data'");
    }
    return '$buffer';
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
