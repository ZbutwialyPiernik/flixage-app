import 'dart:async';

import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget that should be parent to code that wants to display notifications
/// also it has to be children of Scaffold
class NotificationRoot extends StatefulWidget {
  final Widget child;
  final GlobalKey<ScaffoldState> scaffoldKey;

  NotificationRoot({Key key, this.child, this.scaffoldKey}) : super(key: key);

  @override
  _NotificationRootState createState() => _NotificationRootState();
}

class _NotificationRootState extends State<NotificationRoot> {
  StreamSubscription subscription;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<NotificationBloc>(context);

    if (subscription == null)
      subscription = bloc.notifications.listen((notification) {
        widget.scaffoldKey.currentState.showSnackBar(
          SnackBar(
            duration: notification.duration,
            content: Text(
              '${notification.content}',
              style: TextStyle(color: notification.fontColor),
            ),
            backgroundColor: notification.backgroundColor,
          ),
        );
      });

    return widget.child;
  }

  @override
  void dispose() {
    subscription?.cancel();

    super.dispose();
  }
}
