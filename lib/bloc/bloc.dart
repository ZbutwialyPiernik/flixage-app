import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

abstract class BaseBloc<S> {
  Stream<S> get state;

  void dispose();
}

abstract class Bloc<E, S> extends BaseBloc<S> {
  static final Logger logger = Logger();

  void dispatch(E event) {
    try {
      logger.d("Dipatching event in bloc $runtimeType: $event");
      onEvent(event);
    } catch (e) {
      onError(e);
    }
  }

  @protected
  void onEvent(E event);

  @protected
  void onError(Object error) {
    logger.e(Level.error, "Unhandled exception in bloc ${this.toString()}: $error");
  }
}
