import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flixage/bloc/library_bloc.dart';
import 'package:flixage/bloc/audio_player_bloc.dart';
import 'package:flixage/bloc/authentication_bloc.dart';
import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/bloc/search_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/playlist_bloc.dart';

import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/repository/track_repository.dart';
import 'package:flixage/repository/authentication_repository.dart';
import 'package:flixage/repository/user_repository.dart';

import 'package:flixage/ui/pages/audio_player/audio_player.dart';
import 'package:flixage/ui/pages/login/login_page.dart';
import 'package:flixage/ui/pages/app/app_page.dart';
import 'package:flixage/ui/pages/app/settings_page.dart';
import 'package:flixage/ui/pages/loading/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final Dio dio = Dio();

  dio.options.receiveTimeout = 3 * 1000;
  dio.options.sendTimeout = 5 * 1000;

  final AuthenticationRepository authenticationRepository = AuthenticationRepository(dio);
  final UserRepository userRepository = UserRepository(dio);

  final NotificationBloc notificationBloc = NotificationBloc();
  final AudioPlayerBloc audioPlayerBloc = AudioPlayerBloc(AudioPlayer());
  final SearchBloc searchBloc = SearchBloc(TrackRepository(dio));
  final AuthenticationBloc authenticationBloc = AuthenticationBloc(
      authenticationRepository, userRepository, dio, FlutterSecureStorage());
  final LibraryBloc libraryBloc = LibraryBloc(PlaylistRepository(dio));
  final PlaylistBloc playlistBloc = PlaylistBloc(
      playlistRepository: PlaylistRepository(dio),
      libraryBloc: libraryBloc,
      notificationBloc: notificationBloc);

  final GlobalBloc globalBloc = GlobalBloc(
      audioPlayerBloc: audioPlayerBloc,
      searchBloc: searchBloc,
      authenticationBloc: authenticationBloc,
      libraryBloc: libraryBloc,
      playlistBloc: playlistBloc);

  runApp(App(globalBloc: globalBloc, authenticationRepository: authenticationRepository));
}

class App extends StatelessWidget {
  final GlobalBloc globalBloc;
  final AuthenticationRepository authenticationRepository;

  const App({Key key, @required this.globalBloc, @required this.authenticationRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>(
      lazy: false,
      create: (_) {
        return globalBloc..authenticationBloc.dispatch(AppStarted());
      },
      dispose: (_, bloc) => bloc.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Roboto',
          backgroundColor: Colors.grey.shade900,
          primaryColor: Color.fromARGB(255, 96, 30, 61),
          accentColor: Colors.yellowAccent,
          inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            filled: true,
            hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal),
          ),
        ),
        home: StreamBuilder<AuthenticationState>(
          stream: globalBloc.authenticationBloc.state,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state is AuthenticationAuthenticated) {
              return AppPage();
            } else if (state is AuthenticationUnauthenticated) {
              return LoginPage(authenticationRepository);
            }

            return SplashPage();
          },
        ),
        routes: {
          AudioPlayerPage.route: (context) => AudioPlayerPage(),
          SettingsPage.route: (context) => SettingsPage()
        },
      ),
    );
  }
}
