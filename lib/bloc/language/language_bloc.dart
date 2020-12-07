import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:rxdart/rxdart.dart';

abstract class LanguageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;

  ChangeLanguage(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

class LoadLanguage extends LanguageEvent {}

class LanguageBloc extends Bloc<LanguageEvent, Locale> {
  static const _languageKey = "LANGUAGE";
  static const _defaultLanguage = "en";

  final logger = Logger();

  final FlutterSecureStorage _storage;

  final BehaviorSubject<Locale> _languageSubject =
      BehaviorSubject.seeded(Locale(Intl.getCurrentLocale()));

  Stream<Locale> get state => _languageSubject.stream;

  LanguageBloc(this._storage);

  @override
  void onEvent(event) {
    if (event is ChangeLanguage) {
      _storage
          .write(key: _languageKey, value: event.languageCode)
          .then((_) => _loadLanguage(event.languageCode));
    } else if (event is LoadLanguage) {
      _storage.read(key: _languageKey).then((savedLanguage) async {
        logger.d("Reading locale settings");

        if (savedLanguage == null) {
          final systemLanguage = (await findSystemLocale()).split("_").first;

          if (S.delegate.isSupported(Locale(systemLanguage))) {
            logger.d(
                "System locale '$systemLanguage' is supported, settings as default language");

            _storage.write(key: _languageKey, value: systemLanguage);
            savedLanguage = systemLanguage;
          } else {
            logger.d("System locale '$systemLanguage' is not supported");
          }
        }

        final localeToLoad = savedLanguage ?? _defaultLanguage;

        _loadLanguage(localeToLoad);
      });
    }
  }

  void _loadLanguage(String languageCode) {
    if (_languageSubject.value.languageCode == languageCode) {
      return;
    }

    logger.d("Loading language $languageCode");

    final locale = Locale(languageCode);
    S.delegate.load(locale);
    _languageSubject.add(locale);
  }

  @override
  void dispose() {
    super.dispose();

    _languageSubject.close();
  }
}
