import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flixage/generated/l10n.dart';

String mapCommonErrors(dynamic e, {String defaultValue}) {
  if (e is String) {
    return e;
  }

  if (defaultValue == null) {
    defaultValue = S.current.common_unknownError;
  }

  if (e is DioError) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return S.current.dio_connectionTimeout;
      case DioErrorType.RECEIVE_TIMEOUT:
        return S.current.dio_receiveTimeout;
      case DioErrorType.SEND_TIMEOUT:
        return S.current.dio_requestTimeout;
      case DioErrorType.RESPONSE:
        return _mapCommonCodes(e, defaultValue);
    }
  }

  return defaultValue;
}

String _mapCommonCodes(DioError e, String defaultValue) {
  if (e.response.statusCode == HttpStatus.serviceUnavailable) {
    return S.current.dio_serviceUnavailable;
  }

  return defaultValue;
}
