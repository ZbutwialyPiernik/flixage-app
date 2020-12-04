import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/ui/widget/bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultLoadingBlocWidget<B extends BaseBloc<LoadingState<S>>, S>
    extends StatelessWidget {
  final B Function(BuildContext context) create;
  final Widget Function(BuildContext context, B bloc, S state) builder;
  final Widget Function(BuildContext context, B bloc, Object error) onError;
  final Widget Function(BuildContext context, B bloc) onLoading;
  final void Function(BuildContext context, B bloc) onInit;

  DefaultLoadingBlocWidget({
    Key key,
    this.create,
    this.onInit,
    this.builder,
    this.onError,
    this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, LoadingState<S>>(
      create: create,
      onInit: onInit,
      builder: (context, bloc, snapshot) {
        final data = snapshot.data;

        if (snapshot.data is LoadingError) {
          if (onError != null) {
            return onError(context, bloc, snapshot.error);
          } else {
            Provider.of<NotificationBloc>(context)
                .dispatch(SimpleNotification.error(content: snapshot.error));
            return Container();
          }
        }

        if (data is LoadingInProgress ||
            data is LoadingUnitinialized ||
            !snapshot.hasData) {
          if (onLoading != null) {
            return onLoading(context, bloc);
          } else {
            return defaultLoadingWidget();
          }
        }

        return builder(context, bloc, (snapshot.data as LoadingSuccess<S>).item);
      },
    );
  }

  Widget defaultLoadingWidget() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
