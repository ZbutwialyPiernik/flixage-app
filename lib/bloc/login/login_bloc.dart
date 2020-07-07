import 'package:dio/dio.dart';
import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/login/login_state.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/notification/simple_notification.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/util/validation/common_validators.dart';
import 'package:flixage/util/validation/validation_result.dart';
import 'package:flixage/util/validation/validator.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:validators/validators.dart';

import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent> {
  // One upper, one lower, one number, no whitespace

  static final log = Logger();

  final BehaviorSubject<LoginState> _loginState =
      BehaviorSubject.seeded(LoginInitialized());

  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;
  final NotificationBloc notificationBloc;

  Stream<LoginState> get state => _loginState.stream;

  LoginBloc(
      this._authenticationBloc, this._authenticationRepository, this.notificationBloc);

  @override
  void dispose() {
    _loginState.close();
  }

  @override
  void onEvent(LoginEvent event) async {
    if (event is LoginAttempEvent) {
      if (!validateFields(event)) {
        return;
      }

      _loginState.add(LoginLoading());
      _authenticationRepository
          .authenticate({'username': event.username, 'password': event.password}).then(
        (authentication) {
          log.d("Successful login");
          _authenticationBloc.dispatch(LoggedIn(authentication));
        },
      ).catchError((e) {
        if (e is DioError) {
          if (e.request != null) {
            switch (e.response?.statusCode) {
              case 401:
                notificationBloc
                    .dispatch(SimpleNotification.error(content: "Invalid Credentials"));
                break;
              case 400:
                log.e(
                    "Login validator is not properly implemented, server should not throw 400");
                break;
              default:
                log.e(e);
                notificationBloc
                    .dispatch(SimpleNotification.error(content: "Unknown Error"));
            }
          } else {
            log.e(e);
            notificationBloc.dispatch(SimpleNotification.error(content: "Unknown Error"));
          }
        }

        _loginState.add(LoginInitialized());
      });
    } else if (event is TextChangedEvent) {
      // Clearning error flag
      if (_loginState.value is LoginValidatorError) {
        _loginState.add(LoginInitialized());
      }
    }
  }

  bool validateFields(LoginAttempEvent event) {
    ValidationResult usernameValidation = validateUsername(event.username);
    ValidationResult passwordValidation = validatePassword(event.password);

    if (usernameValidation.hasError || passwordValidation.hasError) {
      _loginState.add(LoginValidatorError(usernameValidation, passwordValidation));
      return false;
    }

    return true;
  }

  ValidationResult validateUsername(String username) {
    final validator = Validator.builder()
        .add((value) => value.length < 5, "Username is too short")
        .add((value) => !isAscii(value), "Illegal characters")
        .build();

    return validator.validate(username);
  }

  ValidationResult validatePassword(String password) {
    final validator = Validator.builder()
        .add((value) => value.length < 8, "Password is too short")
        .add((value) => !isAscii(value), "Illegal characters")
        .add(
            (value) =>
                !hasDigit(value, 1) || !hasLowerCase(value, 1) || !hasUpperCase(value, 1),
            "Invalid password")
        .build();

    return validator.validate(password);
  }
}
