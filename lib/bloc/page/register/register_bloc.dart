import 'package:dio/dio.dart';
import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/dio_util.dart';
import 'package:flixage/bloc/form_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/util/validation/common_validators.dart';
import 'package:flixage/util/validation/validator.dart';
import 'package:logger/logger.dart';

class RegisterBloc extends FormBloc {
  static const _usernameKey = 'username';
  static const _passwordKey = 'password';
  static const _repeatPasswordKey = 'repeatPassword';

  static final log = Logger();

  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;

  RegisterBloc(this._authenticationBloc, this._authenticationRepository);

  @override
  Future<FormBlocState> onValid(SubmitForm event) async {
    if (event.fields[_passwordKey] != event.fields[_repeatPasswordKey]) {
      return FormValidationError({
        _usernameKey: ValidationResult.empty(),
        _passwordKey: ValidationResult.empty(),
        _repeatPasswordKey: ValidationResult(
            error: S.current.registerPage_validation_passwordDoesNotMatch)
      });
    }

    try {
      final authentication = await _authenticationRepository.registerUser({
        _usernameKey: event.fields[_usernameKey],
        _passwordKey: event.fields[_passwordKey],
      });

      _authenticationBloc.dispatch(LoggedIn(authentication));

      return FormSubmitSuccess();
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.RESPONSE) {
          switch (e.response?.statusCode) {
            case 409:
              return Future.error(S.current.registerPage_validation_usernameTaken);
              break;
            case 400:
              log.e(
                  "Register validator is not properly implemented, server should not throw 400");
              return Future.error(S.current.common_unknownError);
          }
        }

        return Future.error(
            mapCommonErrors(e, defaultValue: S.current.common_unknownError));
      }

      return Future.error(S.current.common_unknownError);
    }
  }

  @override
  List<FormBlocField> get fields => [
        FormBlocField(
          key: _usernameKey,
          label: S.current.common_username,
          validator: usernameValidator,
        ),
        FormBlocField(
          key: _passwordKey,
          label: S.current.common_password,
          validator: passwordValidator,
          obscuredText: true,
        ),
        FormBlocField(
          key: _repeatPasswordKey,
          label: S.current.registerPage_repeatPassword,
          obscuredText: true,
        ),
      ];
}
