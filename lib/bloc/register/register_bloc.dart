import 'package:dio/dio.dart';
import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/register/register_event.dart';
import 'package:flixage/bloc/register/register_state.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/util/validation/common_validators.dart';
import 'package:flixage/util/validation/validator.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent> {
  static final log = Logger();

  final BehaviorSubject<RegisterState> _loginState = BehaviorSubject();

  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;
  final NotificationBloc notificationBloc;

  Stream<RegisterState> get state => _loginState.stream;

  RegisterBloc(
      this._authenticationBloc, this._authenticationRepository, this.notificationBloc);

  @override
  void dispose() {
    _loginState.close();
  }

  @override
  void onEvent(RegisterEvent event) async {
    if (event is RegisterAttempEvent) {
      if (!validateFields(event)) {
        return;
      }

      _loginState.add(RegisterLoading());
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
              case 409:
                notificationBloc.dispatch(SimpleNotification.error(
                    content: S.current.registerPage_usernameTaken));
                break;
              case 400:
                log.e(
                    "Register validator is not properly implemented, server should not throw 400");
                notificationBloc
                    .dispatch(SimpleNotification.error(content: S.current.unknownError));

                break;
              default:
                log.e(e);
                notificationBloc
                    .dispatch(SimpleNotification.error(content: S.current.unknownError));
            }
          } else {
            log.e(e);
            notificationBloc
                .dispatch(SimpleNotification.error(content: S.current.unknownError));
          }
        }

        _loginState.add(RegisterInitialized());
      });
    } else if (event is TextChangedEvent) {
      if (_loginState.value is RegisterValidatorError) {
        _loginState.add(RegisterInitialized());
      }
    }
  }

  bool validateFields(RegisterAttempEvent event) {
    final usernameValidation = usernameValidator.validate(event.username);
    final passwordValidation = loginPasswordValidator.validate(event.password);
    final repeatPasswordValidation =
        event.repeatPassword.isNotEmpty && event.repeatPassword != event.password
            ? ValidationResult(error: S.current.registerPage_passwordDoesNotMatch)
            : ValidationResult.empty();

    if (usernameValidation.hasError ||
        passwordValidation.hasError ||
        repeatPasswordValidation.hasError) {
      _loginState.add(RegisterValidatorError(
          usernameValidation, passwordValidation, repeatPasswordValidation));
      return false;
    }

    return true;
  }
}
