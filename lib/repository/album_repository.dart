import 'package:dio/dio.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/model/page_response.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/util/constants.dart';
import 'package:retrofit/http.dart';

part 'album_repository.g.dart';

@RestApi(baseUrl: API_SERVER)
abstract class AlbumRepository {
  factory AlbumRepository(Dio dio, {String baseUrl}) = _AlbumRepository;

  @GET("/albums/{id}")
  Future<Album> getById(@Path() String id);

  @GET("/albums/{id}/tracks")
  Future<List<Track>> getTracksById(@Path() String id);

  @GET("/albums/recent")
  Future<PageResponse<Album>> getRecentlyAdded({
    @Query("offset") int offset = 0,
    @Query("limit") int limit = 10,
  });
}
