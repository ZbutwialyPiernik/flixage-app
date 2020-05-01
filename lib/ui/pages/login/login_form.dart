import 'package:flixage/util/stateful_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/bloc/login_bloc.dart';
import 'package:flixage/repository/authentication_repository.dart';

import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthenticationRepository _authenticationRepository;

  LoginForm(this._authenticationRepository, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc _bloc = LoginBloc(
        Provider.of<GlobalBloc>(context).authenticationBloc, _authenticationRepository);

    return StatefulWrapper(
      onDispose: () => _bloc.dispose(),
      child: StreamBuilder<LoginState>(
        stream: _bloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: "Password")),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),
              TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontWeight: FontWeight.normal),
                  )),
              Divider(
                height: 16,
                color: Colors.transparent,
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () => {
                  state is LoginLoading
                      ? null
                      : _bloc.dispatch(
                          LoginAttempEvent(
                              username: _usernameController.value.text,
                              password: _passwordController.value.text),
                        ),
                },
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              ),
            ],
          );
        },
      ),
    );
  }
}
