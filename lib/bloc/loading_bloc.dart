import 'package:flixage/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class LoadingBloc<T, D> extends Bloc<T, D> {
  final BehaviorSubject<D> _subject = BehaviorSubject();

  Stream<D> get state => _subject.stream;

  LoadingBloc();

  Future<D> load(T event);

  @override
  void onEvent(T event) {
    load(event)
        .then((data) => _subject.add(data))
        .catchError((e) => _subject.addError(e));
  }

  @override
  void dispose() {
    _subject.close();
  }
}
