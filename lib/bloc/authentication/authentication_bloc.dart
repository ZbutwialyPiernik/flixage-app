import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/authentication/authentication_interceptor.dart';
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

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  static final log = Logger();

  final BehaviorSubject<AuthenticationState> _authenticationSubject =
      BehaviorSubject.seeded(AuthenticationUninitialized());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final TokenStore _tokenStore;

  User get currentUser => _authenticationSubject.value is AuthenticationAuthenticated
      ? (_authenticationSubject.value as AuthenticationAuthenticated).user
      : null;

  @override
  Stream<AuthenticationState> get state => _authenticationSubject.stream;

  AuthenticationBloc(
      this._authenticationRepository, Dio dio, this._userRepository, this._tokenStore) {
    dio.interceptors.add(AuthenticationInterceptor(
        dio: dio,
        authenticationBloc: this,
        authenticationRepository: _authenticationRepository,
        tokenStore: _tokenStore));
  }

  @override
  void onEvent(AuthenticationEvent event) async {
    if (event is AppStarted) {
      final accessToken = await _tokenStore.getAccessToken();
      final refreshToken = await _tokenStore.getRefreshToken();

      log.d("Retrying authentication with refresh token $refreshToken");

      if (refreshToken != null && accessToken != null) {
        await _authenticationRepository.renewToken({
          TokenStore.ACCESS_TOKEN_KEY: accessToken,
          TokenStore.REFRESH_TOKEN_KEY: refreshToken
        }).then((authentication) {
          log.d(
              "Successful reauthentication with tokens ${authentication.accessToken} and ${authentication.refreshToken}");

          dispatch(LoggedIn(authentication));
        }).catchError((e) {
          log.d("Unsuccesful reauthentication");

          _authenticationSubject.add(AuthenticationUnauthenticated());
        });
      } else {
        _authenticationSubject.add(AuthenticationUnauthenticated());
      }
    } else if (event is LoggedIn) {
      log.d(
          'Saving JWT tokens ${event.authentication.accessToken} and ${event.authentication.refreshToken}');

      await _tokenStore.saveTokens(
          event.authentication.accessToken, event.authentication.refreshToken);

      log.d('Saved JWT tokens');

      _userRepository.getCurrentUser().then((user) async {
        log.d('Downloaded user info, logged in user: ${user.name}');
        _authenticationSubject.add(AuthenticationAuthenticated(user));
      }).catchError((error) {
        log.e('Problem during downloading of user info');
        _authenticationSubject.add(AuthenticationUnauthenticated());
      });
    } else if (event is Logout) {
      var refreshToken = await _tokenStore.getRefreshToken();
      _authenticationRepository
          .invalidateToken({TokenStore.REFRESH_TOKEN_KEY: refreshToken}).catchError(
              (e) => log.e("Error during logout", e));

      _tokenStore
          .flushTokens()
          .then((value) => _authenticationSubject.add(AuthenticationUnauthenticated()));
    }
  }

  @override
  void dispose() {
    _authenticationSubject.close();
  }
}
