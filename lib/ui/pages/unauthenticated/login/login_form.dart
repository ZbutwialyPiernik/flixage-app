import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/login/login_bloc.dart';
import 'package:flixage/bloc/login/login_event.dart';
import 'package:flixage/bloc/login/login_state.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:flixage/repository/authentication_repository.dart';

import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginForm({Key key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                readOnly: state is LoginLoading,
                decoration: InputDecoration(
                  errorText: (state is LoginValidatorError)
                      ? state.usernameValidator.error
                      : null,
                  hintText: "Username",
                ),
              ),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),
              TextField(
                controller: _passwordController,
                readOnly: state is LoginLoading,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: (state is LoginValidatorError)
                      ? state.passwordValidator.error
                      : null,
                  border: InputBorder.none,
                  hintText: "Password",
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.normal),
                ),
              ),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),
              RaisedButton(
                child: Text("LOGIN"),
                onPressed: state is LoginLoading
                    ? null
                    : () => _bloc.dispatch(
                          LoginAttempEvent(
                              username: _usernameController.value.text,
                              password: _passwordController.value.text),
                        ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
