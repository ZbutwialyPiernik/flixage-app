import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/page/register/register_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/ui/widget/form/form_page.dart';
import 'package:flixage/ui/widget/form/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static const route = "register";

  @override
  Widget build(BuildContext context) {
    return FormPage(
      child: Center(
        child: FormWidget(
          createBloc: (context) => RegisterBloc(
            Provider.of<AuthenticationBloc>(context),
            Provider.of<AuthenticationRepository>(context),
          ),
          submitButtonText: S.current.registerPage_register,
        ),
      ),
    );
  }
}
