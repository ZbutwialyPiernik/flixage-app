import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flixage/bloc/language/language_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/l10n/language_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguageTile extends SettingsTile {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LanguageBloc>(context);

    return StreamBuilder<Locale>(
      stream: bloc.state,
      builder: (_, snapshot) => snapshot.hasData
          ? SettingsTile(
              title: S.current.settingsPage_language,
              subtitle: getDisplayLanguage(snapshot.data.languageCode),
              leading: Icon(Icons.language),
              onTap: () {
                showConfirmationDialog<Locale>(
                  context: context,
                  title: "Select language",
                  shrinkWrap: true,
                  actions: S.delegate.supportedLocales
                      .map((locale) => AlertDialogAction(
                            key: locale,
                            label: getDisplayLanguage(locale.languageCode),
                          ))
                      .toList(),
                ).then((value) => bloc.dispatch(ChangeLanguage(value.languageCode)));
              },
            )
          : Container(),
    );
  }
}
