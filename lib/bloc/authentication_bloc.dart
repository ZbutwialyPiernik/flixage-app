import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/model/authentication.dart';
import 'package:flixage/model/user.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  String toString() => 'LoggedIn { token: }';
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

  final BehaviorSubject<AuthenticationState> _authenticationState =
      BehaviorSubject.seeded(AuthenticationUninitialized());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final FlutterSecureStorage _storage;
  final Dio _dio;

  Stream<AuthenticationState> get state => _authenticationState.stream;

  AuthenticationBloc(
      this._authenticationRepository, this._userRepository, this._dio, this._storage) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          if (!options.path.contains("authentication")) {
            options.headers['Authorization'] =
                "Bearer " + await _storage.read(key: 'accessToken');
          }
          return options;
        },
        onResponse: (Response response) async {
          return response;
        },
        onError: (DioError e) async {
          if (e.response?.statusCode == 401) {
            log.e("error while request: $e");
            _dio.interceptors.requestLock.lock();
            _dio.interceptors.responseLock.lock();

            var accessToken = await _storage.read(key: 'accessToken');
            var refreshToken = await _storage.read(key: 'refreshToken');

            _authenticationRepository
                .renewToken({refreshToken: refreshToken, accessToken: accessToken}).then(
                    (authentication) {
              _saveTokens(authentication.accessToken, authentication.refreshToken);
            }).catchError((e) {
              _flushTokens();
              _authenticationState.add(AuthenticationUnauthenticated());
            });

            _dio.interceptors.requestLock.unlock();
            _dio.interceptors.responseLock.unlock();
          } else {
            return e;
          }
        },
      ),
    );
  }

  @override
  void onEvent(AuthenticationEvent event) async {
    if (event is AppStarted) {
      var accessToken = await _storage.read(key: 'accessToken');
      var refreshToken = await _storage.read(key: 'refreshToken');

      if (refreshToken != null && accessToken != null) {
        _authenticationRepository
            .renewToken({'accessToken': accessToken, 'refreshToken': refreshToken}).then(
                (authentication) {
          _saveTokens(authentication.accessToken, authentication.refreshToken);
          dispatch(LoggedIn(authentication));
        }).catchError((e) {
          _authenticationState.add(AuthenticationUnauthenticated());
        });
      } else {
        _authenticationState.add(AuthenticationUnauthenticated());
      }
    } else if (event is LoggedIn) {
      _saveTokens(event.authentication.accessToken, event.authentication.refreshToken);
      var user = await _userRepository.getCurrentUser();

      _authenticationState.add(AuthenticationAuthenticated(user));
    } else if (event is Logout) {
      var refreshToken = await _storage.read(key: 'refreshToken');

      _authenticationRepository.invalidateToken({'refreshToken': refreshToken});
      _flushTokens();

      _authenticationState.add(AuthenticationUnauthenticated());
    }
  }

  @override
  void dispose() {
    _authenticationState.close();
  }

  void _flushTokens() {
    _storage.delete(key: 'refreshToken');
    _storage.delete(key: 'accessToken');
  }

  void _saveTokens(String accessToken, String refreshToken) {
    _storage.write(key: 'accessToken', value: accessToken);
    _storage.write(key: 'refreshToken', value: refreshToken);
  }
}
