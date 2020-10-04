import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/form_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/page/register/register_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static const route = "register";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: RegisterForm(),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notificationBloc = Provider.of<NotificationBloc>(context);
    final authenticationRepository = Provider.of<AuthenticationRepository>(context);

    final bloc = RegisterBloc(Provider.of<AuthenticationBloc>(context),
        authenticationRepository, notificationBloc);

    return StatefulWrapper(
      onInit: () {
        _usernameController.addListener(() {
          bloc.dispatch(TextChanged({
            'username': _usernameController.text,
            'password': _passwordController.text,
            'repeatPassword': _repeatPasswordController.text,
          }));
        });

        _passwordController.addListener(() {
          bloc.dispatch(TextChanged({
            'username': _usernameController.text,
            'password': _passwordController.text,
            'repeatPassword': _repeatPasswordController.text,
          }));
        });

        _repeatPasswordController.addListener(() {
          bloc.dispatch(TextChanged({
            'username': _usernameController.text,
            'password': _passwordController.text,
            'repeatPassword': _repeatPasswordController.text,
          }));
        });
      },
      onDispose: () {
        _usernameController.dispose();
        _passwordController.dispose();
        _repeatPasswordController.dispose();

        bloc.dispose();
      },
      child: StreamBuilder<FormBlocState>(
        stream: bloc.formState,
        builder: (context, snapshot) {
          final state = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(S.current.authenticationPage_username),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _usernameController,
                readOnly: state is FormLoading,
                decoration: InputDecoration(
                  errorText: (state is FormValidationError)
                      ? state.errors['username'].error
                      : null,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(S.current.authenticationPage_password),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _passwordController,
                readOnly: state is FormLoading,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: (state is FormValidationError)
                      ? state.errors['password'].error
                      : null,
                  border: InputBorder.none,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(S.current.registerPage_repeatPassword),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _repeatPasswordController,
                readOnly: state is FormLoading,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: (state is FormValidationError)
                      ? state.errors['repeatPassword'].error
                      : null,
                  border: InputBorder.none,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text(S.current.authenticationPage_register.toUpperCase()),
                    color: Theme.of(context).primaryColor,
                    onPressed: state is FormLoading
                        ? null
                        : () => bloc.dispatch(
                              SubmitForm({
                                'username': _usernameController.value.text,
                                'password': _passwordController.value.text,
                                'repeatPassword': _repeatPasswordController.value.text,
                              }),
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
