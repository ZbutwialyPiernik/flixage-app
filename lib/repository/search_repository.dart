import 'package:dio/dio.dart';
import 'package:flixage/model/search_response.dart';
import 'package:flixage/util/constants.dart';
import 'package:retrofit/http.dart';

part 'search_repository.g.dart';

@RestApi(baseUrl: API_SERVER)
abstract class SearchRepository {
  factory SearchRepository(Dio dio, {String baseUrl}) = _SearchRepository;

  @GET("/search")
  Future<SearchResponse> search(
      {@Query("query") String query,
      @Query("offset") int offset,
      @Query("limit") int limit,
      @Query("type") String type});
}
