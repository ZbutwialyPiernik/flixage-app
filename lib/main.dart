import 'package:dio/dio.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/ui/authentication_root.dart';
import 'package:flixage/ui/widget/bloc_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/repository/user_repository.dart';

import 'bloc/authentication/authentication_bloc.dart';

import 'package:flixage/ui/config/theme.dart';
import 'package:flixage/ui/config/custom_scroll_behaviour.dart';

import 'bloc/token_store.dart';

import 'package:intl/intl_standalone.dart';

const languageKey = "LANGUAGE";
const defaultLanguage = "en";

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  findSystemLocale().then((value) {
    final logger = Logger();

    final dio = Dio();
    final authenticationRepository = AuthenticationRepository(dio);
    final secureStorage = FlutterSecureStorage();
    final tokenStore = TokenStore(secureStorage);

    secureStorage.read(key: languageKey).then((savedLanguage) async {
      logger.d("Reading locale settings");

      if (savedLanguage == null) {
        final systemLanguage = (await findSystemLocale()).split("_").first;

        if (S.delegate.isSupported(Locale(systemLanguage))) {
          logger.d(
              "System locale '$systemLanguage' is supported, settings as default language");

          secureStorage.write(key: languageKey, value: systemLanguage);
          savedLanguage = systemLanguage;
        } else {
          logger.d("System locale '$systemLanguage' is not supported");
        }
      }

      final localeToLoad = savedLanguage ?? defaultLanguage;

      logger.d("Loading locale '$savedLanguage'");

      S.delegate.load(Locale(localeToLoad));
    });

    dio.options.connectTimeout = 2 * 2000;
    dio.options.receiveTimeout = 2 * 1000;
    dio.options.sendTimeout = 2 * 1000;

    runApp(Main(
      dio: dio,
      tokenStore: tokenStore,
      authenticationRepository: authenticationRepository,
    ));
  });
}

class Main extends StatelessWidget {
  final Dio dio;
  final TokenStore tokenStore;
  final AuthenticationRepository authenticationRepository;

  const Main({Key key, this.dio, this.tokenStore, this.authenticationRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(
            authenticationRepository,
            UserRepository(dio),
            dio,
            tokenStore,
          )..dispatch(AppStarted()),
          lazy: false,
        ),
        Provider<AuthenticationRepository>.value(value: authenticationRepository),
        Provider<TokenStore>.value(value: tokenStore),
        Provider<Dio>.value(value: dio),
        Provider<NotificationBloc>(create: (_) => NotificationBloc()),
      ],
      //lazy: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'Flixage',
        theme: theme,
        home: SafeArea(
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: AuthenticationRoot(),
          ),
        ),
      ),
    );
  }
}
