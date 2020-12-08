import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/ui/widget/bloc_builder.dart';
import 'package:flixage/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultLoadingBlocBuilder<B extends BaseBloc<LoadingState<S>>, S>
    extends StatefulWidget {
  final B Function(BuildContext context) create;
  final Widget Function(BuildContext context, B bloc, S state) builder;
  final Widget Function(BuildContext context, B bloc, Object error) onError;
  final Widget Function(BuildContext context, B bloc) onLoading;
  final void Function(BuildContext context, S state) listener;
  final void Function(BuildContext context, B bloc) onInit;

  DefaultLoadingBlocBuilder({
    Key key,
    @required this.builder,
    this.create,
    this.listener,
    this.onInit,
    this.onError,
    this.onLoading,
  }) : super(key: key);

  @override
  _DefaultLoadingBlocBuilderState<B, S> createState() =>
      _DefaultLoadingBlocBuilderState<B, S>();
}

class _DefaultLoadingBlocBuilderState<B extends BaseBloc<LoadingState<S>>, S>
    extends State<DefaultLoadingBlocBuilder<B, S>> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, LoadingState<S>>(
      create: widget.create,
      onInit: widget.onInit,
      builder: (context, bloc, state) {
        if (state is LoadingError<S>) {
          if (widget.onError != null) {
            return widget.onError(context, bloc, state.message);
          } else {
            Provider.of<NotificationBloc>(context)
                .dispatch(SimpleNotification.error(content: state.message));

            return Container();
          }
        }

        if (state == null ||
            state is LoadingInProgress ||
            state is LoadingUnitinialized) {
          if (widget.onLoading != null) {
            return widget.onLoading(context, bloc);
          } else {
            return LoadingWidget();
          }
        }

        return widget.builder(context, bloc, (state as LoadingSuccess<S>).item);
      },
    );
  }
}
