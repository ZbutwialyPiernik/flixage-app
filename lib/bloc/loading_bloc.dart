import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';

abstract class LoadingBloc<T extends Equatable, R extends Equatable> extends Bloc<T> {
  Stream<R> get stream;
}
