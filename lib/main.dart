import 'package:dio/dio.dart';
import 'package:flixage/bloc/authentication/network_state_interceptor.dart';
import 'package:flixage/bloc/language/language_bloc.dart';
import 'package:flixage/bloc/networt_status_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/ui/bloc_util.dart';
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

import 'bloc/authentication/logging_interceptor.dart';
import 'bloc/token_store.dart';

final Logger logger = Logger();

final int defaultConnectTimeout = const Duration(seconds: 5).inMilliseconds;
final int defaultReceiveTimeout = const Duration(seconds: 5).inMilliseconds;
final int defaultSendTimeout = const Duration(seconds: 5).inMilliseconds;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  logger.d("Base url is: $API_SERVER");

  // Dio used for authenticated requests, if tokens expires, then this instance
  // gets locked and unauthenticated dio sends request to refresh token, then
  // authenticated dio retries the original request.
  final authenticatedDio = Dio();
  final unauthenticatedDio = Dio();

  final networkBloc = NetworkStatusBloc();

  _setupDio("Authenticated", authenticatedDio, networkBloc);
  _setupDio("Unauthenticated", unauthenticatedDio, networkBloc);

  final authenticationRepository = AuthenticationRepository(unauthenticatedDio);
  final secureStorage = FlutterSecureStorage();
  final tokenStore = TokenStore(secureStorage);

  runApp(Main(
    dio: authenticatedDio,
    tokenStore: tokenStore,
    authenticationRepository: authenticationRepository,
    secureStorage: secureStorage,
    networkBloc: networkBloc,
  ));
}

_setupDio(String name, Dio dio, NetworkStatusBloc networkBloc) {
  dio.options.baseUrl = API_SERVER;
  dio.options.connectTimeout = defaultConnectTimeout;
  dio.options.receiveTimeout = defaultReceiveTimeout;
  dio.options.sendTimeout = defaultSendTimeout;

  dio.interceptors.add(NetworkStateInterceptor(networkBloc));
  dio.interceptors.add(LoggingInterceptor(name));
}

class Main extends StatelessWidget {
  final Dio dio;
  final TokenStore tokenStore;
  final FlutterSecureStorage secureStorage;
  final AuthenticationRepository authenticationRepository;
  final NetworkStatusBloc networkBloc;

  const Main({
    Key key,
    @required this.dio,
    @required this.tokenStore,
    @required this.authenticationRepository,
    @required this.secureStorage,
    @required this.networkBloc,
  }) : super(key: key);

  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        Provider<Dio>.value(value: dio),
        repositoryProvider<UserRepository>((dio) => UserRepository(dio)),
        repositoryProvider<AuthenticationRepository>(
            (dio) => AuthenticationRepository(dio)),
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(
            authenticationRepository,
            dio,
            UserRepository(dio),
            tokenStore,
          )..dispatch(AppStarted()),
          lazy: false,
        ),
        BlocProvider<NotificationBloc>(create: (_) => NotificationBloc()),
        BlocProvider<LanguageBloc>(
          create: (_) => LanguageBloc(secureStorage)..dispatch(LoadLanguage()),
          lazy: false,
        ),
        Provider<TokenStore>.value(value: tokenStore),
        Provider<NetworkStatusBloc>.value(value: networkBloc),
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
