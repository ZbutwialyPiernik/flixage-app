import 'package:flixage/generated/l10n.dart';
import 'package:flixage/l10n/language_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LanguageDropdown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _currentLanguage;

  @override
  void initState() {
    _currentLanguage = Intl.getCurrentLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _currentLanguage,
      items: S.delegate.supportedLocales
          .map(
            (e) => DropdownMenuItem(
              value: e.languageCode,
              child: Text(
                getDisplayLanguage(e.languageCode),
              ),
            ),
          )
          .toList(),
      onChanged: (value) => setState(() {
        _currentLanguage = value;
        S.delegate.load(Locale(value));
      }),
    );
  }
}
