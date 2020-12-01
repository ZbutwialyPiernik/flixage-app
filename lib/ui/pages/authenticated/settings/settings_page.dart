import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/ui/pages/authenticated/settings/language_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AuthenticationBloc>(context);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppBar(
            brightness: Brightness.light,
            centerTitle: true,
            title: Text(S.current.settingsPage_title,
                style: Theme.of(context).textTheme.headline6),
          ),
          Expanded(
            child: SettingsList(
              sections: [
                SettingsSection(
                  title: 'General',
                  tiles: [
                    LanguageTile(),
                  ],
                ),
                SettingsSection(
                  title: 'Account',
                  tiles: [
                    SettingsTile(
                      title: S.current.settingsPage_logout,
                      leading: Icon(Icons.exit_to_app),
                      onTap: () {
                        bloc.dispatch(Logout());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
