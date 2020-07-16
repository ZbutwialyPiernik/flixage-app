import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/login/login_bloc.dart';
import 'package:flixage/bloc/login/login_event.dart';
import 'package:flixage/bloc/login/login_state.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/ui/widget/notification_root.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const route = "login";

  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notificationBloc = Provider.of<NotificationBloc>(context);
    final authenticationRepository = Provider.of<AuthenticationRepository>(context);

    final LoginBloc _bloc = LoginBloc(Provider.of<AuthenticationBloc>(context),
        authenticationRepository, notificationBloc);

    return StatefulWrapper(
      onInit: () {
        _usernameController.addListener(() {
          _bloc.dispatch(TextChangedEvent(
              username: _usernameController.text, password: _passwordController.text));
        });

        _passwordController.addListener(() {
          _bloc.dispatch(TextChangedEvent(
              username: _usernameController.text, password: _passwordController.text));
        });

        // TODO: remove harded login for faster testing
        _usernameController.text = "admin";
        _passwordController.text = "Passw0rd";
      },
      onDispose: () {
        _usernameController.dispose();
        _passwordController.dispose();

        _bloc.dispose();
      },
      child: StreamBuilder<LoginState>(
        stream: _bloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(S.current.authenticationPage_username),
              Divider(
                height: 8,
                color: Colors.transparent,
              ),
              TextField(
                controller: _usernameController,
                readOnly: state is LoginLoading,
                decoration: InputDecoration(
                  errorText: (state is LoginValidatorError)
                      ? state.usernameValidator.error
                      : null,
                  hintText: S.current.authenticationPage_username,
                ),
              ),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),
              Text(S.current.authenticationPage_password),
              Divider(
                height: 8,
                color: Colors.transparent,
              ),
              TextFormField(
                controller: _passwordController,
                readOnly: state is LoginLoading,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: (state is LoginValidatorError)
                      ? state.passwordValidator.error
                      : null,
                  border: InputBorder.none,
                  filled: true,
                ),
              ),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text(S.current.authenticationPage_login.toUpperCase()),
                    color: Theme.of(context).primaryColor,
                    onPressed: state is LoginLoading
                        ? null
                        : () => _bloc.dispatch(
                              LoginAttempEvent(
                                  username: _usernameController.value.text,
                                  password: _passwordController.value.text),
                            ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: StadiumBorder(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
