extension DoubleExtension on double {
  bool isBetween(double a, double b) {
    return this >= a && this <= b;
  }
}

extension IntExtension on int {
  bool isBetween(int a, int b) {
    return this >= a && this <= b;
  }
}
