import 'package:dio/dio.dart';
import 'package:flixage/generated/l10n.dart';

String mapCommonErrors(DioError e, {String defaultValue}) {
  switch (e.type) {
    case DioErrorType.CONNECT_TIMEOUT:
      return S.current.dio_connectionTimeout;
    case DioErrorType.RECEIVE_TIMEOUT:
      return S.current.dio_receiveTimeout;
    case DioErrorType.SEND_TIMEOUT:
      return S.current.dio_requestTimeout;
    case DioErrorType.RESPONSE:
      return _mapErrorCodes(e, defaultValue);
    default:
      return defaultValue;
  }
}

_mapErrorCodes(DioError e, String defaultValue) {
  switch (e.response.statusCode) {
    default:
      return defaultValue;
  }
}
