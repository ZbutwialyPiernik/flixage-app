import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/dio_util.dart';
import 'package:flutter/cupertino.dart';
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

class LoadingError<T> extends LoadingState<T> {
  final String message;

  LoadingError(this.message);

  @override
  List<Object> get props => [message];
}

abstract class LoadingBloc<T, D> extends Bloc<AbstractLoad<T>, LoadingState<D>> {
  @protected
  Future<D> load(T event);
}

abstract class AbstractLoadingBloc<T, D> extends LoadingBloc<T, D> {
  @protected
  final BehaviorSubject<LoadingState<D>> subject =
      BehaviorSubject.seeded(LoadingUnitinialized());

  Stream<LoadingState<D>> get state => subject.stream;

  @override
  void onEvent(AbstractLoad<T> event) {
    subject.add(LoadingInProgress());

    load(event.arg)
        .then((data) => subject.add(LoadingSuccess(data)))
        .catchError((e) => subject.add(LoadingError(mapCommonErrors(e))));
  }

  @override
  void dispose() {
    super.dispose();

    subject.close();
  }
}
