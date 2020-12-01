import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/dio_util.dart';
import 'package:rxdart/rxdart.dart';

abstract class AbstractLoad<T> extends Equatable {
  T get arg;
}

class Load<T> extends AbstractLoad<T> {
  final T arg;

  Load({this.arg});

  @override
  List<Object> get props => [arg];
}

abstract class LoadingState<T> extends Equatable {}

class LoadingUnitinialized<T> extends LoadingState<T> {
  @override
  List<Object> get props => [];
}

class LoadingInProgress<T> extends LoadingState<T> {
  @override
  List<Object> get props => [];
}

class LoadingSuccess<T> extends LoadingState<T> {
  final T item;

  LoadingSuccess(this.item);

  @override
  List<Object> get props => [item];
}

abstract class LoadingBloc<T, D> extends Bloc<AbstractLoad<T>, LoadingState<D>> {
  final BehaviorSubject<LoadingState<D>> _subject =
      BehaviorSubject.seeded(LoadingUnitinialized());

  Stream<LoadingState<D>> get state => _subject.stream;

  LoadingBloc();

  Future<D> load(T event);

  @override
  void onEvent(AbstractLoad<T> event) {
    _subject.add(LoadingInProgress());

    load(event.arg)
        .then((data) => _subject.add(LoadingSuccess(data)))
        .catchError((e) => _subject.addError(mapCommonErrors(e)));
  }

  @override
  void dispose() {
    _subject.close();
  }
}
