import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class LoadingBloc<T extends Equatable, D extends Equatable> extends Bloc<T> {
  final BehaviorSubject<D> _subject = BehaviorSubject();

  Stream<D> get stream => _subject.stream;

  LoadingBloc();

  Future<D> load(T event);

  @override
  void onEvent(T event) {
    load(event).then((data) => _subject.add(data));
  }

  @override
  void dispose() {
    _subject.close();
  }
}
