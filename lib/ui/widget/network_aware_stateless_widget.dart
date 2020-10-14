import 'package:flixage/bloc/networt_status_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

typedef Widget NetworkBuilder(BuildContext context, NetworkStatus status);

class NetworkAwareWidget extends StatelessWidget {
  final NetworkBuilder builder;

  NetworkAwareWidget({this.builder});

  Widget build(BuildContext context) {
    final bloc = Provider.of<NetworkStatusBloc>(context);

    return StreamBuilder(
      stream: bloc.networkStatus,
      builder: (context, state) => builder(context, state.data),
    );
  }
}
