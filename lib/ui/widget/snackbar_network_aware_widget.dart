import 'package:flixage/bloc/networt_status_bloc.dart';
import 'package:flixage/ui/widget/network_aware_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Widget NetworkBuilder(BuildContext context, NetworkStatus status);

class SnackbarNetworkAwareWidget extends StatelessWidget {
  final NetworkBuilder child;

  const SnackbarNetworkAwareWidget({Key key, this.child}) : super(key: key);

  Widget build(BuildContext context) {
    return NetworkAwareWidget(builder: (context, status) {
      if (status == NetworkStatus.Offline) {
        return Stack(
          children: [
            child(context, status),
            //Align(
            // alignment: Alignment.bottomCenter,
            //child: SnackBar(
            //  content: Text("You're offline"),
            // ),
            //)
          ],
        );
      }

      return child(context, status);
    });
  }
}
