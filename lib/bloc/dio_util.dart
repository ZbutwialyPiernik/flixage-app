import 'package:dio/dio.dart';
import 'package:flixage/generated/l10n.dart';

String mapCommonErrors(dynamic e, {String defaultValue}) {
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
      default:
        return defaultValue;
    }
  }

  return e;
}
