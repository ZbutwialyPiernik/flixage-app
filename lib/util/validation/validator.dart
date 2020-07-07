import 'package:flixage/util/validation/validation_result.dart';
import 'package:flixage/util/validation/validator_step.dart';

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
  final List<ValidatorStep> steps = List();

  ValidatorBuilder add(Predicate predicate, message) {
    steps.add(ValidatorStep(predicate, message));
    return this;
  }

  Validator build() => Validator._(steps);
}
