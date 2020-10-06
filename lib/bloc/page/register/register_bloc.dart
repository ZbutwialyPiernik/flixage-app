import 'package:dio/dio.dart';
import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/form_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/util/validation/common_validators.dart';
import 'package:flixage/util/validation/validator.dart';
import 'package:logger/logger.dart';

class RegisterBloc extends FormBloc {
  static final log = Logger();

  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;
  final NotificationBloc notificationBloc;

  RegisterBloc(
      this._authenticationBloc, this._authenticationRepository, this.notificationBloc);

  @override
  Future<FormBlocState> onValid(SubmitForm event) async {
    if (event.fields['password'] != event.fields['repeatPassword']) {
      return FormValidationError({
        'username': ValidationResult.empty(),
        'password': ValidationResult.empty(),
        'repeatPassword':
            ValidationResult(error: S.current.registerPage_passwordDoesNotMatch)
      });
    }

    _authenticationRepository.registerUser({
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

      return FormInitialized();
    });
  }

  @override
  Map<String, Validator> get validators => {
        'username': usernameValidator,
        'password': passwordValidator,
      };
}
