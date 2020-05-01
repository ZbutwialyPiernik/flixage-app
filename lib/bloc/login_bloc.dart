import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/authentication_bloc.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

abstract class LoginEvent extends Equatable {}

enum QueryType { audio, playlist, album }

class LoginAttempEvent extends LoginEvent {
  final String username;
  final String password;

  LoginAttempEvent({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

abstract class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialized extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError({this.error});

  @override
  List<Object> get props => [error];
}

class LoginBloc extends Bloc<LoginEvent> {
  static final log = Logger();

  final BehaviorSubject<LoginState> _loginState =
      BehaviorSubject.seeded(LoginInitialized());

  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;

  Stream<LoginState> get state => _loginState.stream;

  LoginBloc(this._authenticationBloc, this._authenticationRepository);

  @override
  void dispose() {
    _loginState.close();
  }

  @override
  void onEvent(LoginEvent event) async {
    if (event is LoginAttempEvent) {
      try {
        _loginState.add(LoginLoading());
        _authenticationRepository
            .authenticate({'username': event.username, 'password': event.password}).then(
          (authentication) {
            _authenticationBloc.dispatch(LoggedIn(authentication));
          },
        );
      } catch (e) {
        if (e is DioError) {
          switch (e.response?.statusCode) {
            case 401:
              _loginState.add(LoginError(error: "Invalid credentials"));
              break;
            default:
              _loginState.add(LoginError(error: "Unknown Error"));
          }
        }
      }
    }
  }
}
