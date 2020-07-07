import 'package:flixage/ui/pages/unauthenticated/login/login_form.dart';
import 'package:flixage/ui/widget/notification_root.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const route = "login";

  final scaffoldKey = GlobalKey<ScaffoldState>();

  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationRoot(
      scaffoldKey: scaffoldKey,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(width: 128, height: 128, color: Colors.blue),
                      Divider(
                        height: 64,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
