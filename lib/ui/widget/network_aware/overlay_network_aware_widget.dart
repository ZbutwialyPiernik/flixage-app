import 'dart:async';

import 'package:flixage/bloc/networt_status_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class OverlayNetworkAwarePage extends StatelessWidget {
  final Widget child;

  OverlayNetworkAwarePage({this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [child, Overlay()],
    );
  }
}

class Overlay extends StatefulWidget {
  Overlay();

  @override
  _OverlayState createState() => _OverlayState();
}

class _OverlayState extends State<Overlay> with SingleTickerProviderStateMixin {
  AnimationController controller;

  StreamSubscription<NetworkStatus> _subscription;

  NetworkStatus _status;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _subscription?.cancel();
    _subscription = Provider.of<NetworkStatusBloc>(context).state.listen((status) {
      if (_status == status) {
        return;
      }

      status == NetworkStatus.Offline ? controller.forward() : controller.reverse();
      _status = status;
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if ((!controller.isAnimating) && controller. ) return Container();

    return Stack(
      children: [
        /*
        Expanded(
          child: AnimatedOpacity(
            opacity: _status == NetworkStatus.Online ? 0 : 0.5,
            duration: Duration(seconds: 4),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),*/
        Align(
          alignment: Alignment.bottomCenter,
          child: SlideTransition(
            position: controller.drive(Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(
              curve: Curves.fastOutSlowIn,
            ))),
            child: _buildBanner(),
          ),
        )
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 40,
      color: Colors.redAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.current.common_offline, style: Theme.of(context).textTheme.subtitle1),
          SizedBox(width: 8),
          SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
