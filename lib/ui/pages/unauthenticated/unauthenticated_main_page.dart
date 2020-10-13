import 'package:flixage/ui/pages/unauthenticated/login/login_page.dart';
import 'package:flixage/ui/pages/unauthenticated/register/register_page.dart';
import 'package:flixage/ui/widget/notification_root.dart';
import 'package:flutter/material.dart';

class UnauthenticatedMainPage extends StatelessWidget {
  final unauthenticatedRoutes = {
    LoginPage.route: (_) => LoginPage(),
    RegisterPage.route: (_) => RegisterPage(),
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
            initialRoute: LoginPage.route,
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
