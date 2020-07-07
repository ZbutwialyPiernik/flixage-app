import 'package:dio/dio.dart';
import 'package:flixage/model/track.dart';
import 'package:retrofit/http.dart';

import 'package:flixage/util/constants.dart';

part 'track_repository.g.dart';

@RestApi(baseUrl: API_SERVER)
abstract class TrackRepository {
  factory TrackRepository(Dio dio, {String baseUrl}) = _TrackRepository;

  @GET("/tracks/{id}")
  Future<Track> getById(@Path() String id);

  
  @POST("/tracks/{id}/streamCount")
  Future<void> increaseStreamCount(@Path() String id);
}
