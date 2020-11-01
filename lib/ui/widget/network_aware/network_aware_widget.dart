import 'package:flixage/bloc/networt_status_bloc.dart';
import 'package:flixage/ui/widget/bloc_builder.dart';
import 'package:flutter/material.dart';

typedef Widget NetworkBuilder(BuildContext context, NetworkStatus status);

class NetworkAwareWidget extends StatelessWidget {
  final NetworkBuilder builder;

  NetworkAwareWidget({this.builder}) : assert(builder != null);

  Widget build(BuildContext context) {
    return BlocBuilder<NetworkStatusBloc, NetworkStatus>(
      builder: (context, _, state) =>
          builder(context, state.data ?? NetworkStatus.Offline),
    );
  }
}
