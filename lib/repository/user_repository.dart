import 'package:dio/dio.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/model/page_response.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flixage/model/user.dart';

part 'user_repository.g.dart';

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET("/users/{id}")
  Future<User> getById(@Path() String id);

  @GET("/users/me")
  Future<User> getCurrentUser();

  @GET("/users/me/recentlyListened")
  Future<PageResponse<Track>> getRecentlyListened({
    @Query("offset") int offset = 0,
    @Query("limit") int limit = 10,
  });

  @GET("/users/me/mostListened")
  Future<PageResponse<Artist>> getMostListened({
    @Query("offset") int offset = 0,
    @Query("limit") int limit = 10,
  });

  @GET("/users/me/followedPlaylists")
  Future<List<Playlist>> getFollowedPlaylist();

}
