typedef Predicate = bool Function(String);

class ValidatorStep {
  final Predicate predicate;
  final String message;

  ValidatorStep(this.predicate, this.message);
}
