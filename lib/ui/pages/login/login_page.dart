import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/ui/pages/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  const LoginPage(this._authenticationRepository, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(width: 92, height: 92, color: Colors.blue),
                    Divider(
                      height: 64,
                      color: Colors.transparent,
                    ),
                  ],
                ),
                LoginForm(_authenticationRepository),
                Text("Change password here")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
