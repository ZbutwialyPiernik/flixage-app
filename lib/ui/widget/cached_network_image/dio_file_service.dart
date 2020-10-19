import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flixage/ui/widget/cached_network_image/dio_cache_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// ignore: implementation_imports
import 'package:flutter_cache_manager/src/web/mime_converter.dart';
import 'package:path/path.dart' as path;

class DioFileService extends FileService {
  final Settings _settings;
  final Dio _dio;

  DioFileService(this._dio, this._settings);

  @override
  Future<FileServiceResponse> get(String url, {Map<String, String> headers}) async {
    Response<List<int>> response = await _dio.get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: _settings.headerPolicy == HeaderPolicy.Replace
            ? headers
            : _mergeHeaders(headers),
      ),
    );

    return HttpGetResponse(
        response, _settings.allowHttpCacheHeaders, _settings.cacheDuration);
  }

  _mergeHeaders(Map<String, String> headers) {
    Map<String, String> newHeaders = Map();
    newHeaders.addAll(_settings.headers);
    newHeaders.addAll(headers);

    return newHeaders;
  }
}

class HttpGetResponse implements FileServiceResponse {
  final Response<List<int>> _response;
  final DateTime _receivedTime = DateTime.now();
  final bool _allowHttpCacheHeaders;
  final Duration _defaultCacheDuration;

  HttpGetResponse(
      this._response, this._allowHttpCacheHeaders, this._defaultCacheDuration);

  @override
  int get statusCode => _response.statusCode;

  bool _hasHeader(String name) => _response.headers[name] != null;

  String _header(String name) => _response.headers.value(name);

  @override
  Stream<List<int>> get content => Stream.value(_response.data);

  @override
  int get contentLength => _response.data.length;

  @override
  DateTime get validTill {
    var ageDuration = _defaultCacheDuration;

    if (_allowHttpCacheHeaders && _hasHeader(HttpHeaders.cacheControlHeader)) {
      final controlSettings = _header(HttpHeaders.cacheControlHeader).split(',');
      for (final setting in controlSettings) {
        final sanitizedSetting = setting.trim().toLowerCase();
        if (sanitizedSetting == 'no-cache') {
          ageDuration = const Duration();
        }
        if (sanitizedSetting.startsWith('max-age=')) {
          var validSeconds = int.tryParse(sanitizedSetting.split('=')[1]) ?? 0;
          if (validSeconds > 0) {
            ageDuration = Duration(seconds: validSeconds);
          }
        }
      }
    }

    return _receivedTime.add(ageDuration);
  }

  @override
  String get eTag => _header(HttpHeaders.etagHeader);

  /// Returns extension based on common mime-types if mime type is not present,
  /// then tries to extract type from request url
  @override
  String get fileExtension {
    var extension = '';

    if (_hasHeader(HttpHeaders.contentTypeHeader)) {
      var contentType = ContentType.parse(_header(HttpHeaders.contentTypeHeader));
      extension = contentType.fileExtension ?? '';
    }

    if (extension.isEmpty) {
      extension = path.extension(_response.request.uri.toString());
    }

    if (extension == '.') {
      extension = '';
    }

    return extension;
  }
}
