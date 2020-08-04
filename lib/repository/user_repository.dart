import 'package:dio/dio.dart';
import 'package:flixage/model/page_response.dart';
import 'package:flixage/model/track.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flixage/util/constants.dart';
import 'package:flixage/model/user.dart';

part 'user_repository.g.dart';

@RestApi(baseUrl: API_SERVER)
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET("/users/{id}")
  Future<User> getById(@Path() String id);

  @GET("/users/me")
  Future<User> getCurrentUser();

  @GET("/users/me/recent")
  Future<PageResponse<Track>> getRecentlyListened({
    @Query("offset") int offset = 0,
    @Query("limit") int limit = 10,
  });
}
