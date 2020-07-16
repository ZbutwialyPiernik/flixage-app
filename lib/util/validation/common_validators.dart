import 'package:flixage/generated/l10n.dart';
import 'package:flixage/util/validation/validator.dart';
import 'package:validators/validators.dart';

final usernameValidator = Validator.builder()
    .add((value) => value.length < 5, S.current.authenticationPage_tooShort)
    .add((value) => value.length > 32, S.current.authenticationPage_tooLong)
    .add((value) => !isAscii(value), S.current.authenticationPage_illegalCharacters)
    .build();

final loginPasswordValidator = Validator.builder()
    .add((value) => value.length < 8, S.current.authenticationPage_tooShort)
    .add((value) => value.length > 128, S.current.authenticationPage_tooLong)
    .add((value) => !isAscii(value), S.current.authenticationPage_illegalCharacters)
    .add(
        (value) =>
            !hasDigit(value, 1) || !hasLowerCase(value, 1) || !hasUpperCase(value, 1),
        S.current.loginPage_invalidPassword)
    .build();

final registerPasswordValidator = Validator.builder()
    .add((value) => value.length < 8, S.current.authenticationPage_tooShort)
    .add((value) => value.length > 128, S.current.authenticationPage_tooLong)
    .add((value) => !isAscii(value), S.current.authenticationPage_illegalCharacters)
    .add((value) => !hasDigit(value, 1), S.current.registerPage_oneDigit)
    .add((value) => !hasLowerCase(value, 1), S.current.registerPage_oneLower)
    .add((value) => !hasUpperCase(value, 1), S.current.registerPage_oneUpper)
    .build();

/// Checks if [value] contains AT LEAST [number] of uppercase character
bool hasUpperCase(String value, int number) {
  return new RegExp("[A-Z]{$number,}").hasMatch(value);
}

/// Checks if [value] contains AT LEAST [number] of uppercase character
bool hasLowerCase(String value, int number) {
  return new RegExp("[a-z]{$number,}").hasMatch(value);
}

/// Checks if [value] contains AT LEAST [number] of digits
bool hasDigit(String value, int number) {
  return new RegExp("[0-9]{$number,}").hasMatch(value);
}
