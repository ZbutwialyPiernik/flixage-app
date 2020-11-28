import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';
import 'package:retrofit/http.dart';

part 'playlist_repository.g.dart';

@RestApi()
abstract class PlaylistRepository {
  factory PlaylistRepository(Dio dio, {String baseUrl}) = _PlaylistRepository;

  @GET("/playlists/{id}")
  Future<Playlist> getById(@Path() String id);

  @POST("/playlists")
  Future<Playlist> create(@Body() Map<String, dynamic> body);

  @PUT("/playlists/{id}")
  Future<Playlist> update(@Path("id") String id, @Body() Playlist playlist);

  @POST("/playlists/{id}/thumbnail")
  Future<void> uploadThumbnail(@Path("id") String id, @Part() File file);

  @GET("/playlists/{id}/tracks")
  Future<List<Track>> getTracksFromPlaylist(@Path("id") String id);

  @DELETE("/playlists/{id}")
  Future<void> delete(@Path("id") String id);

  @PUT("/playlists/{id}/tracks")
  Future<void> addTracks(@Path("id") String id, @Body() Map<String, dynamic> tracks);

  @DELETE("/playlists/{id}/tracks")
  Future<void> removeTrack(@Path("id") String id, @Body() Map<String, dynamic> tracks);

  // User oriented
  @GET("/users/{userId}/playlists")
  Future<List<Playlist>> getUserPlaylists(@Path("userId") String userId);

  @GET("/users/me/playlists")
  Future<List<Playlist>> getCurrentUserPlaylists();

  @PUT("/playlist/{id}/followers")
  Future<void> followPlaylist(@Path() String id);

  @DELETE("/playlist/{id}/followers")
  Future<void> unfollowPlaylist(@Path() String id);
}
