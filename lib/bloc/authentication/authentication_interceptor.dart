import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/token_store.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

const String AUTHORIZATION_HEADER = "Authorization";
const String AUTHORIZATION_PREFIX = "Bearer ";

class AuthenticationInterceptor extends Interceptor {
  static final log = Logger();

  final Dio dio;
  final TokenStore tokenStore;
  final AuthenticationRepository authenticationRepository;
  final AuthenticationBloc authenticationBloc;

  AuthenticationInterceptor({
    @required this.dio,
    @required this.tokenStore,
    @required this.authenticationRepository,
    @required this.authenticationBloc,
  });

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    dio.interceptors.requestLock.lock();

    if (!options.path.contains("authentication")) {
      options.headers[AUTHORIZATION_HEADER] =
          AUTHORIZATION_PREFIX + await tokenStore.getAccessToken();
    }

    dio.interceptors.requestLock.unlock();

    return options;
  }

  @override
  Future<dynamic> onError(DioError error) async {
    // If access token will expire, resource server will throw 401
    if (error.response != null && error.response.statusCode == HttpStatus.unauthorized) {
      dio.lock();

      final refreshToken = await tokenStore.getRefreshToken();

      try {
        final authentication =
            await authenticationRepository.renewToken({"refreshToken": refreshToken});

        await tokenStore.saveTokens(
            authentication.accessToken, authentication.refreshToken);

        dio.unlock();

        // When authentication is renewed we retry the reqeust
        return await dio.request(
          error.request.path,
          cancelToken: error.request.cancelToken,
          data: error.request.data,
          onReceiveProgress: error.request.onReceiveProgress,
          onSendProgress: error.request.onSendProgress,
          queryParameters: error.request.queryParameters,
          options: error.request,
        );
      } catch (e) {
        // After unsucessfull retry to logout we flush tokens and redirect to Login Page
        tokenStore.flushTokens().then((value) => authenticationBloc.dispatch(Logout()));

        return error;
      }
    } else {
      return error;
    }
  }
}
