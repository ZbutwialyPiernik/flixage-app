import 'package:dio/dio.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/ui/root.dart';
import 'package:flixage/ui/widget/bloc_provider.dart';

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/repository/user_repository.dart';

import 'bloc/authentication/authentication_bloc.dart';

import 'package:flixage/ui/config/theme.dart';
import 'package:flixage/ui/config/custom_scroll_behaviour.dart';

import 'bloc/token_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();
  final authenticationRepository = AuthenticationRepository(dio);
  final tokenStore = TokenStore(FlutterSecureStorage());

  dio.options.connectTimeout = 2 * 2000;
  dio.options.receiveTimeout = 1 * 1000;
  dio.options.sendTimeout = 1 * 1000;

  runApp(Main(
    dio: dio,
    tokenStore: tokenStore,
    authenticationRepository: authenticationRepository,
  ));
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
        title: 'Flutter Demo',
        theme: theme,
        home: SafeArea(
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: Root(),
          ),
        ),
      ),
    );
  }
}
