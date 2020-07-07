// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SearchRepository implements SearchRepository {
  _SearchRepository(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://10.0.2.2:8080/api';
  }

  final Dio _dio;

  String baseUrl;

  @override
  search({query, offset, limit, type}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'query': query,
      'offset': offset,
      'limit': limit,
      'type': type
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('/search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchResponse.fromJson(_result.data);
    return Future.value(value);
  }
}
