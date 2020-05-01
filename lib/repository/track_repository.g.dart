// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _TrackRepository implements TrackRepository {
  _TrackRepository(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://10.0.2.2:3000';
  }

  final Dio _dio;

  String baseUrl;

  @override
  fetchAudio({id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/track/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Track.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  searchAudio({query, limit}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'query': query, 'limit': limit};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/track',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Track.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }
}
