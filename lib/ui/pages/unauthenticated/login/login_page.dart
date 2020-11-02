import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/page/login/login_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/ui/pages/unauthenticated/register/register_page.dart';
import 'package:flixage/ui/widget/form/form_page.dart';
import 'package:flixage/ui/widget/form/form_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/*
    if (!kReleaseMode) {
      _usernameController.text = "admin";
      _passwordController.text = "Passw0rd";
    }*/

class LoginPage extends StatelessWidget {
  static const route = "login";

  LoginPage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return FormPage(
      child: Column(
        children: [
          SizedBox(height: 64),
          FormWidget(
            createBloc: (context) => LoginBloc(
              Provider.of<AuthenticationBloc>(context),
              AuthenticationRepository(Provider.of(context)),
            ),
            submitButtonText: S.current.loginPage_login,
          ),
          SizedBox(height: 64),
          FlatButton(
            child: Text(
              S.current.authenticationPage_register,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(fontSize: 16, decoration: TextDecoration.underline),
            ),
            onPressed: () => Navigator.of(context).pushNamed(RegisterPage.route),
          ),
        ],
      ),
    );
  }
}
