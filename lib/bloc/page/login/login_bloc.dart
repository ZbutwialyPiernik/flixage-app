import 'package:dio/dio.dart';
import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/form_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/util/validation/common_validators.dart';
import 'package:flixage/util/validation/validator.dart';
import 'package:logger/logger.dart';

class LoginBloc extends FormBloc {
  // One upper, one lower, one number, no whitespace

  static final log = Logger();

  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;
  final NotificationBloc notificationBloc;

  LoginBloc(
      this._authenticationBloc, this._authenticationRepository, this.notificationBloc);

  @override
  FormBlocState onValid(SubmitForm event) {
    _authenticationRepository.authenticate({
      'username': event.fields['username'],
      'password': event.fields['password']
    }).then(
      (authentication) {
        _authenticationBloc.dispatch(LoggedIn(authentication));
        return FormSubmitSuccess();
      },
    ).catchError((e) {
      if (e is DioError) {
        if (e.request != null) {
          switch (e.response?.statusCode) {
            case 401:
              notificationBloc.dispatch(SimpleNotification.error(
                  content: S.current.loginPage_invalidCredentials));
              break;
            case 400:
              log.e(
                  "Login validator is not properly implemented, server should not throw 400");
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

      return FormInitialized();
    });
  }

  @override
  Map<String, Validator> get validators => {
        'username': usernameValidator,
        'password': passwordValidator,
      };
}
