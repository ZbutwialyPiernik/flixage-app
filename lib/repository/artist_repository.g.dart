// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ArtistRepository implements ArtistRepository {
  _ArtistRepository(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://10.0.2.2:8080/api';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getById(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('/artists/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = Artist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getSingles(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/artists/$id/singles',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Track.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  getAlbums(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/artists/$id/albums',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Album.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  getRecentlyAdded({offset = 0, limit = 10}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'offset': offset, 'limit': limit};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('/artists/recent',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra, baseUrl: baseUrl),
        data: _data);
    final value = PageResponse<Artist>.fromJson(_result.data, Artist.fromJson);
    return Future.value(value);
  }
}
