import 'package:dio/dio.dart';
import 'package:flixage/model/page_response.dart';
import 'package:flixage/model/track.dart';
import 'package:retrofit/http.dart';

part 'track_repository.g.dart';

@RestApi()
abstract class TrackRepository {
  factory TrackRepository(Dio dio, {String baseUrl}) = _TrackRepository;

  @GET("/tracks/{id}")
  Future<Track> getById(@Path() String id);

  @POST("/tracks/{id}/streamCount")
  Future<void> increaseStreamCount(@Path() String id);

  @GET("/tracks/recent")
  Future<PageResponse<Track>> getRecentlyAdded({
    @Query("offset") int offset = 0,
    @Query("limit") int limit = 10,
  });
}
