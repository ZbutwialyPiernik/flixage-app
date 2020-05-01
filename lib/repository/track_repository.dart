import 'package:dio/dio.dart';
import 'package:flixage/model/track.dart';
import 'package:retrofit/http.dart';

import 'package:flixage/constants.dart';

part 'track_repository.g.dart';

@RestApi(baseUrl: API_SERVER)
abstract class TrackRepository {
  factory TrackRepository(Dio dio, {String baseUrl}) = _TrackRepository;

  @GET("/track/{id}")
  Future<Track> fetchAudio({@Path("id") String id});

  @GET("/track")
  Future<List<Track>> searchAudio(
      {@Query("query") String query, @Query("limit") int limit});
}
