import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/ui/pages/authenticated/settings/language_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AuthenticationBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppBar(
          centerTitle: true,
          title: Text(S.current.settingsPage_title,
              style: Theme.of(context).textTheme.headline6),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(S.current.settingsPage_language),
                  LanguageDropdown()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      bloc.dispatch(Logout());
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        Text(S.current.settingsPage_logout)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
