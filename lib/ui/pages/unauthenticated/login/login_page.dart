import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/form_bloc.dart';
import 'package:flixage/bloc/page/login/login_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/ui/pages/unauthenticated/register/register_page.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/foundation.dart';
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

    final LoginBloc _bloc =
        LoginBloc(Provider.of<AuthenticationBloc>(context), authenticationRepository);

    return StatefulWrapper(
      onInit: () {
        _usernameController.addListener(() {
          _bloc.dispatch(TextChanged({
            'username': _usernameController.text,
            'password': _passwordController.text,
          }));
        });

        _passwordController.addListener(() {
          _bloc.dispatch(TextChanged({
            'username': _usernameController.text,
            'password': _passwordController.text,
          }));
        });

        // Only in non-realise mode for faster logging as default admin user
        if (!kReleaseMode) {
          _usernameController.text = "admin";
          _passwordController.text = "Passw0rd";
        }
      },
      onDispose: () {
        _usernameController.dispose();
        _passwordController.dispose();

        _bloc.dispose();
      },
      child: StreamBuilder<FormBlocState>(
        stream: _bloc.formState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          final isFormDisabled = state is FormLoading || state is FormSubmitSuccess;

          if (state is FormError) {
            notificationBloc.dispatch(SimpleNotification.error(content: state.error));
          }

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(S.current.authenticationPage_username),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _usernameController,
                    readOnly: isFormDisabled,
                    decoration: InputDecoration(
                      errorText: (state is FormValidationError)
                          ? state.errors['username'].error
                          : null,
                      hintText: S.current.authenticationPage_username,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(S.current.authenticationPage_password),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    readOnly: isFormDisabled,
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
                    height: 32,
                  ),
                  Center(
                    child: RaisedButton(
                      child: Text(S.current.authenticationPage_login.toUpperCase()),
                      color: Theme.of(context).primaryColor,
                      onPressed: isFormDisabled
                          ? null
                          : () => _bloc.dispatch(SubmitForm({
                                'username': _usernameController.value.text,
                                'password': _passwordController.value.text,
                              })),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      S.current.authenticationPage_register,
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(fontSize: 16, decoration: TextDecoration.underline),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pushNamed(RegisterPage.route),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
