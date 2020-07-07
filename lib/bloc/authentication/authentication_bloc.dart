import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/token_store.dart';
import 'package:flixage/model/authentication.dart';
import 'package:flixage/model/user.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final Authentication authentication;

  const LoggedIn(this.authentication);

  @override
  List<Object> get props => [authentication];

  @override
  String toString() => """LoggedIn 
  accessToken: ${authentication.accessToken}
  refreshToken: ${authentication.refreshToken}""";
}

class Logout extends AuthenticationEvent {}

abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  AuthenticationAuthenticated(this.user);
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationBloc extends Bloc<AuthenticationEvent> {
  static final log = Logger();

  static const String AUTHORIZATION_HEADER = "Authorization";
  static const String AUTHORIZATION_PREFIX = "Bearer ";

  final BehaviorSubject<AuthenticationState> _authenticationState =
      BehaviorSubject.seeded(AuthenticationUninitialized());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final TokenStore _tokenStore;
  final Dio _dio;

  Stream<AuthenticationState> get state => _authenticationState.stream;

  AuthenticationBloc(
      this._authenticationRepository, this._userRepository, this._dio, this._tokenStore) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          if (!options.path.contains("authentication")) {
            options.headers[AUTHORIZATION_HEADER] =
                AUTHORIZATION_PREFIX + await _tokenStore.getAccessToken();
          }

          log.d("""
          SENDING REQUEST:
          status: ${options.headers}
          request: ${options.path}
          body: ${options.data}
          """);

          return options;
        },
        onResponse: (Response response) async {
          log.d("""
          RESPONSE FROM SERVER:
          status: ${response.statusCode}
          request: ${response.request.path}
          body: ${response.data}
          """);

          return response;
        },
        onError: (DioError error) async {
          if (error.response != null) {
            // If access token will expire, resource server will throw 401
            if (!error.request.path.contains("authentication") &&
                error.response?.statusCode == 401) {
              _dio.interceptors.requestLock.lock();
              _dio.interceptors.responseLock.lock();

              var refreshToken = await _tokenStore.getRefreshToken();

              _authenticationRepository.renewToken({"refreshToken": refreshToken}).then(
                  (authentication) async {
                await _tokenStore.saveTokens(
                    authentication.accessToken, authentication.refreshToken);

                // When authentication is renewed we retry the reqeust
                return await _dio.request(
                  error.request.path,
                  cancelToken: error.request.cancelToken,
                  data: error.request.data,
                  onReceiveProgress: error.request.onReceiveProgress,
                  onSendProgress: error.request.onSendProgress,
                  queryParameters: error.request.queryParameters,
                  options: error.request,
                );
              }).catchError((e) async {
                // After unsucessfull retry to logout we flush tokens and redirect to Login Page
                _tokenStore.flushTokens().then(
                    (value) => _authenticationState.add(AuthenticationUnauthenticated()));

                return error;
              });

              _dio.interceptors.requestLock.unlock();
              _dio.interceptors.responseLock.unlock();
            } else {
              log.e("""
                  ERROR DURING REQUEST:
                  error: [${error.response?.statusCode}] ${error.response?.statusMessage}
                  request url: ${error.request.baseUrl + error.request.path}
                  response body: ${error.response?.data}""");

              return error;
            }
          } else {
            log.e("""
              ERROR WITHOUT RESPONSE:
              error: ${error.error}
              error message: ${error.message}
              error type: ${error.type}
              headers: ${error.request.headers}
              request url: ${error.request.baseUrl + error.request.path}
            """);

            return error;
          }
        },
      ),
    );
  }

  @override
  void onEvent(AuthenticationEvent event) async {
    if (event is AppStarted) {
      var accessToken = await _tokenStore.getAccessToken();
      var refreshToken = await _tokenStore.getRefreshToken();

      if (refreshToken != null && accessToken != null) {
        _authenticationRepository
            .renewToken({'accessToken': accessToken, 'refreshToken': refreshToken}).then(
                (authentication) {
          dispatch(LoggedIn(authentication));
        }).catchError((e) {
          _authenticationState.add(AuthenticationUnauthenticated());
        });
      } else {
        _authenticationState.add(AuthenticationUnauthenticated());
      }
    } else if (event is LoggedIn) {
      log.d('Saving JWT tokens');

      await _tokenStore.saveTokens(
          event.authentication.accessToken, event.authentication.refreshToken);

      log.d('Saved JWT tokens');

      _userRepository.getCurrentUser().then((user) {
        log.d('Downloaded user info, logged in user: ${user.name}');
        _authenticationState.add(AuthenticationAuthenticated(user));
      }).catchError((error) {
        log.e('Problem during downloading of user info');
        _authenticationState.add(AuthenticationUnauthenticated());
      });
    } else if (event is Logout) {
      var refreshToken = await _tokenStore.getRefreshToken();
      _authenticationRepository
          .invalidateToken({'refreshToken': refreshToken}).catchError(
              (error) => log.e("Error during logout"));

      _tokenStore
          .flushTokens()
          .then((value) => _authenticationState.add(AuthenticationUnauthenticated()));
    }
  }

  @override
  void dispose() {
    _authenticationState.close();
  }
}
