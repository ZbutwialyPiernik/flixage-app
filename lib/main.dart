import 'package:dio/dio.dart';
import 'package:flixage/bloc/language/language_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/ui/pages/authentication_root.dart';
import 'package:flixage/ui/widget/bloc_provider.dart';
import 'package:flixage/util/constants.dart';
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

final Logger logger = Logger();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();
  final authenticationRepository = AuthenticationRepository(dio);
  final secureStorage = FlutterSecureStorage();
  final tokenStore = TokenStore(secureStorage);

  logger.d("Base url is: $API_SERVER");

  dio.options.baseUrl = API_SERVER;
  dio.options.connectTimeout = 7 * 1000;
  dio.options.receiveTimeout = 10 * 1000;
  dio.options.sendTimeout = 10 * 1000;

  runApp(Main(
    dio: dio,
    tokenStore: tokenStore,
    authenticationRepository: authenticationRepository,
    secureStorage: secureStorage,
  ));
}

class Main extends StatelessWidget {
  final Dio dio;
  final TokenStore tokenStore;
  final FlutterSecureStorage secureStorage;
  final AuthenticationRepository authenticationRepository;

  const Main({
    Key key,
    this.dio,
    this.tokenStore,
    this.authenticationRepository,
    this.secureStorage,
  }) : super(key: key);

  @override
  Widget build(context) {
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
        BlocProvider<NotificationBloc>(
          create: (_) => NotificationBloc(),
        ),
        BlocProvider<LanguageBloc>(
          create: (_) => LanguageBloc(secureStorage)..dispatch(LoadLanguage()),
          lazy: false,
        ),
        Provider<AuthenticationRepository>.value(value: authenticationRepository),
        Provider<TokenStore>.value(value: tokenStore),
        Provider<Dio>.value(value: dio),
      ],
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
