import 'package:flixage/bloc/networt_status_bloc.dart';
import 'package:flixage/ui/widget/network_aware_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultNetworkAwarePage extends StatelessWidget {
  final Widget child;

  DefaultNetworkAwarePage({this.child});

  Widget build(BuildContext context) {
    return NetworkAwareWidget(builder: (context, status) {
      if (status == NetworkStatus.Offline) {
        return Center(
          child: Text("You're offline", style: Theme.of(context).textTheme.headline4),
        );
      }

      return child;
    });
  }
}
