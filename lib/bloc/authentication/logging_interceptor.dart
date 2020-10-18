import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  static final log = Logger();

  final String name;

  LoggingInterceptor(this.name);

  @override
  onRequest(RequestOptions options) async {
    log.d("""
          [${DateTime.now()}][$name] REQUEST:
          status: ${options.headers}
          request: ${options.path}
          body: ${options.data}
          """);

    return options;
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    log.d("""
          [${DateTime.now()}][$name] RESPONSE:
          status: ${response.statusCode}
          request: ${response.request.path}
          body: ${response.data is Uint8List ? '(byte data)' : response.data}
          """);

    return response;
  }

  @override
  onError(DioError error) async {
    if (error.response != null) {
      log.e("""
            [${DateTime.now()}][$name] ERROR DURING REQUEST:
              error: [${error.response?.statusCode}] ${error.response?.statusMessage}
              request url: ${error.request.baseUrl + error.request.path}
              response body: ${error.response?.data}
            """);
    } else {
      log.e("""
            [${DateTime.now()}][$name] ERROR WITHOUT RESPONSE:
              error: ${error.error}
              error message: ${error.message}
              error type: ${error.type}
              headers: ${error.request.headers}
              request url: ${error.request.baseUrl + error.request.path}
            """);
    }

    return error;
  }
}
