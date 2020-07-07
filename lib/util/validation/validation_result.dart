class ValidationResult {
  final String error;

  ValidationResult({this.error});

  bool get hasError => error != null;

  static empty() => ValidationResult();
}
