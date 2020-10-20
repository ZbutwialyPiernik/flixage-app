import 'package:flixage/generated/l10n.dart';
import 'package:flixage/util/validation/validator.dart';
import 'package:validators/validators.dart';

final usernameValidator = Validator.builder()
    .add((value) => value.length < 5, S.current.common_validation_tooShort)
    .add((value) => value.length > 32, S.current.common_validation_tooLong)
    .add((value) => !isAscii(value), S.current.common_validation_illegalCharacters)
    .build();

final passwordValidator = Validator.builder()
    .add((value) => value.length < 8, S.current.common_validation_tooShort)
    .add((value) => value.length > 128, S.current.common_validation_tooLong)
    .add((value) => !isAscii(value), S.current.authenticationPage_illegalCharacters)
    .add((value) => !hasDigit(value, 1), S.current.registerPage_validation_oneDigit)
    .add((value) => !hasLowerCase(value, 1), S.current.registerPage_validation_oneLower)
    .add((value) => !hasUpperCase(value, 1), S.current.registerPage_validation_oneUpper)
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
