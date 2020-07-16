import 'package:dio/dio.dart';
import 'package:flixage/util/constants.dart';
import 'package:retrofit/http.dart';

import 'package:flixage/model/authentication.dart';

part 'authentication_repository.g.dart';

@RestApi(baseUrl: API_SERVER)
abstract class AuthenticationRepository {
  factory AuthenticationRepository(Dio dio, {String baseUrl}) = _AuthenticationRepository;

  @POST("/authentication")
  Future<Authentication> authenticate(@Body() Map<String, dynamic> body);

  @POST("/authentication/renew")
  Future<Authentication> renewToken(@Body() Map<String, dynamic> body);

  @POST("/authentication/invalidate")
  Future<void> invalidateToken(@Body() Map<String, dynamic> body);

  @POST("/authentication/register")
  Future<Authentication> registerUser(@Body() Map<String, dynamic> body);
}
