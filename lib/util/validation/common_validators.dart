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
