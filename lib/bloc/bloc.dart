import 'package:logger/logger.dart';

abstract class Bloc<E> {
  static final Logger logger = Logger();

  void dispatch(E event) {
    try {
      onEvent(event);
    } catch (e) {
      onError(e);
    }
  }

  void onEvent(E event);

  void onError(Exception error) {
    logger.e(Level.error, "Unhandled exception in bloc ${this.toString()}: $error");
  }

  void dispose();
}
