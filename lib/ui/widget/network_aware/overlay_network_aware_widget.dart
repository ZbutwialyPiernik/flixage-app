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
  static const double bannerHeight = 40;

  AnimationController _controller;
  Animation<double> _tween;

  StreamSubscription<NetworkStatus> _subscription;
  NetworkStatus _status;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() => setState(() {}));
    _tween = Tween<double>(
      begin: 0,
      end: 1,
    )
        .chain(
          CurveTween(
            curve: Curves.fastOutSlowIn,
          ),
        )
        .animate(_controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _subscription?.cancel();
    _subscription = Provider.of<NetworkStatusBloc>(context).state.listen((status) {
      if (_status == status) {
        return;
      }

      status == NetworkStatus.Offline ? _controller.forward() : _controller.reverse();
      _status = status;
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Logger().d(_controller.status);

    if (_controller.status == AnimationStatus.dismissed &&
        _status == NetworkStatus.Online) return Container();

    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(_tween.value.clamp(0, 0.5)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.translate(
            offset: Offset(0, bannerHeight - _tween.value * bannerHeight),
            child: _buildBanner(),
          ),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      height: bannerHeight,
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
