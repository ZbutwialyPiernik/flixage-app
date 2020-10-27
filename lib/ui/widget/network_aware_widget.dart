import 'package:flixage/bloc/networt_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef Widget NetworkBuilder(BuildContext context, NetworkStatus status);

class NetworkAwareWidget extends StatelessWidget {
  final NetworkBuilder builder;

  NetworkAwareWidget({this.builder}) : assert(builder != null);

  Widget build(BuildContext context) {
    final bloc = Provider.of<NetworkStatusBloc>(context);

    return StreamBuilder(
      stream: bloc.status,
      builder: (context, state) => builder(context, state.data ?? NetworkStatus.Offline),
    );
  }
}
