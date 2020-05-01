import 'package:dio/dio.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';
import 'package:retrofit/http.dart';

import 'package:flixage/constants.dart';

part 'playlist_repository.g.dart';

@RestApi(baseUrl: API_SERVER)
abstract class PlaylistRepository {
  factory PlaylistRepository(Dio dio, {String baseUrl}) = _PlaylistRepository;

  @GET("/playlists")
  Future<List<Playlist>> searchPlaylists(@Query("q") String query);

  @POST("/playlists")
  Future<Playlist> createPlaylist(@Body() Map<String, dynamic> body);

  @PUT("/playlists/{playlistId}")
  Future<Playlist> updatePlaylist(
      @Path("playlistId") String playlistId, @Body() Playlist playlist);

  @DELETE("/playlists")
  Future<void> deletePlaylist(@Path("playlistId") String playlistId);

  @POST("/playlists/{playlistId}/tracks")
  Future<void> addTrackToPlaylist(
      @Path("playlistId") String playlistId, @Body() List<String> tracks);

  @DELETE("/playlists/{playlistId}/tracks")
  Future<void> removeTracksFromPlaylist(
      @Path("playlistId") String playlistId, @Body() List<String> tracks);

  @GET("/playlists/{playlistId}/tracks")
  Future<List<Track>> getTracksFromPlaylist(@Path("userId") String userId);

  @GET("/users/{userId}/playlists")
  Future<List<Playlist>> getUserPlaylists(@Path("userId") String userId);

  @GET("/users/me/playlists")
  Future<List<Playlist>> getCurrentUserPlaylists();
}
