import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/ui/widget/bloc_builder.dart';
import 'package:flixage/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultLoadingBlocBuilder<B extends BaseBloc<LoadingState<S>>, S>
    extends StatelessWidget {
  final B Function(BuildContext context) create;
  final Widget Function(BuildContext context, B bloc, S state) builder;
  final Widget Function(BuildContext context, B bloc, Object error) onError;
  final Widget Function(BuildContext context, S state) listener;
  final Widget Function(BuildContext context, B bloc) onLoading;
  final void Function(BuildContext context, B bloc) onInit;

  DefaultLoadingBlocBuilder({
    Key key,
    this.create,
    this.onInit,
    this.builder,
    this.onError,
    this.listener,
    this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, LoadingState<S>>(
      create: create,
      onInit: onInit,
      builder: (context, bloc, state) {
        if (state is LoadingError<S>) {
          if (onError != null) {
            return onError(context, bloc, state.message);
          } else {
            Provider.of<NotificationBloc>(context)
                .dispatch(SimpleNotification.error(content: state.message));

            return Container();
          }
        }

        if (state == null ||
            state is LoadingInProgress ||
            state is LoadingUnitinialized) {
          if (onLoading != null) {
            return onLoading(context, bloc);
          } else {
            return LoadingWidget();
          }
        }

        return builder(context, bloc, (state as LoadingSuccess<S>).item);
      },
    );
  }
}
