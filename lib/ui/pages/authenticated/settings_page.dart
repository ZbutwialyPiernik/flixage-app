import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AuthenticationBloc>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  bloc.dispatch(Logout());
                  Navigator.pop(context);
                },
                child: Row(
                  children: <Widget>[Icon(Icons.exit_to_app), Text("Logout")],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
