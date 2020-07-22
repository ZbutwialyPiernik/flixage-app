import 'package:flixage/bloc/language/language_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/l10n/language_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LanguageBloc>(context);

    return StreamBuilder<Locale>(
      stream: bloc.currentLocale,
      builder: (_, snapshot) => DropdownButton(
        value: snapshot.hasData ? snapshot.data.languageCode : null,
        items: S.delegate.supportedLocales
            .map((locale) => DropdownMenuItem(
                value: locale.languageCode,
                child: Text(getDisplayLanguage(locale.languageCode))))
            .toList(),
        onChanged: (value) => bloc.dispatch(ChangeLanguage(value)),
      ),
    );
  }
}
