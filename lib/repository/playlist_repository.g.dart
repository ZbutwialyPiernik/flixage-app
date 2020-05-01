// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PlaylistRepository implements PlaylistRepository {
  _PlaylistRepository(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://10.0.2.2:3000';
  }

  final Dio _dio;

  String baseUrl;

  @override
  searchPlaylists(query) async {
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'q': query};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/playlists',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Playlist.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  createPlaylist(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/playlists/{playlistId}',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Playlist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  updatePlaylist(playlistId, playlist) async {
    ArgumentError.checkNotNull(playlistId, 'playlistId');
    ArgumentError.checkNotNull(playlist, 'playlist');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playlist?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/playlists/$playlistId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Playlist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  deletePlaylist(playlistId) async {
    ArgumentError.checkNotNull(playlistId, 'playlistId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/playlists',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  addTrackToPlaylist(playlistId, tracks) async {
    ArgumentError.checkNotNull(playlistId, 'playlistId');
    ArgumentError.checkNotNull(tracks, 'tracks');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = tracks;
    await _dio.request<void>('/playlists/$playlistId/tracks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  removeTracksFromPlaylist(playlistId, tracks) async {
    ArgumentError.checkNotNull(playlistId, 'playlistId');
    ArgumentError.checkNotNull(tracks, 'tracks');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = tracks;
    await _dio.request<void>('/playlists/$playlistId/tracks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  getTracksFromPlaylist(userId) async {
    ArgumentError.checkNotNull(userId, 'userId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/playlists/{playlistId}/tracks',
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

  @override
  getUserPlaylists(userId) async {
    ArgumentError.checkNotNull(userId, 'userId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/users/$userId/playlists',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Playlist.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  getCurrentUserPlaylists() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/users/me/playlists',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Playlist.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }
}
