class BaseException implements Exception {
  final message;

  BaseException({this.message});

  String toString() {
    return message;
  }
}
