typedef Predicate = bool Function(String);

class Validator {
  final List<ValidatorStep> _steps;

  Validator._(this._steps);

  ValidationResult validate(String value) {
    for (var step in _steps) {
      if (step.predicate(value)) {
        return ValidationResult(error: step.message);
      }
    }

    return ValidationResult.empty();
  }

  static ValidatorBuilder builder() => ValidatorBuilder();
}

class ValidatorBuilder {
  final List<ValidatorStep> _steps = List();

  ValidatorBuilder add(Predicate predicate, message) {
    _steps.add(ValidatorStep(predicate, message));
    return this;
  }

  Validator build() => Validator._(_steps);
}

class ValidationResult {
  final String error;

  ValidationResult({this.error});

  bool get hasError => error != null;

  static empty() => ValidationResult();
}

class ValidatorStep {
  final Predicate predicate;
  final String message;

  ValidatorStep(this.predicate, this.message);
}
