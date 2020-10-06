import 'package:dio/dio.dart';
import 'package:flixage/model/search_response.dart';
import 'package:retrofit/http.dart';

part 'search_repository.g.dart';

@RestApi()
abstract class SearchRepository {
  factory SearchRepository(Dio dio, {String baseUrl}) = _SearchRepository;

  @GET("/search")
  Future<SearchResponse> search({
    @Query("query") String query,
    @Query("offset") int offset = 0,
    @Query("limit") int limit = 10,
    @Query("type") String type,
  });
}
