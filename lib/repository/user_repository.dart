import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flixage/constants.dart';
import 'package:flixage/model/user.dart';

part 'user_repository.g.dart';

@RestApi(baseUrl: API_SERVER)
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET("/users/{id}")
  Future<User> getUserById({@Path("id") String id});

  @GET("/users/me")
  Future<User> getCurrentUser();
}
