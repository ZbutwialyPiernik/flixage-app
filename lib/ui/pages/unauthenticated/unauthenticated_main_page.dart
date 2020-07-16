import 'package:flixage/generated/l10n.dart';
import 'package:flixage/ui/pages/unauthenticated/login/login_page.dart';
import 'package:flixage/ui/pages/unauthenticated/register/register_page.dart';
import 'package:flixage/ui/widget/notification_root.dart';
import 'package:flutter/material.dart';

class UnauthenticatedMainPage extends StatelessWidget {
  final unauthenticatedRoutes = {
    LoginPage.route: (_) => LoginPage(),
    RegisterPage.route: (_) => RegisterPage(),
    RoutePage.route: (_) => RoutePage(),
  };

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return NotificationRoot(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        body: WillPopScope(
          onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
          child: Navigator(
            key: _navigatorKey,
            initialRoute: RoutePage.route,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                  settings: settings, builder: unauthenticatedRoutes[settings.name]);
            },
          ),
        ),
      ),
    );
  }
}

class RoutePage extends StatelessWidget {
  static const route = "route";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, bottom: 64, right: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: StadiumBorder(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(S.current.authenticationPage_login),
              ],
            ),
            onPressed: () => Navigator.of(context).pushNamed(LoginPage.route),
          ),
          SizedBox(height: 16),
          RaisedButton(
            color: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: StadiumBorder(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(S.current.authenticationPage_register),
              ],
            ),
            onPressed: () => Navigator.of(context).pushNamed(RegisterPage.route),
          )
        ],
      ),
    );
  }
}
