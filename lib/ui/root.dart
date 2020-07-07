import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dio/dio.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/library/library_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/token_store.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/repository/track_repository.dart';
import 'package:flixage/ui/pages/app/main_app_page.dart';
import 'package:flixage/ui/pages/routes/audio_player/audio_player.dart';
import 'package:flixage/ui/pages/routes/playlist/pick_playlist_page.dart';
import 'package:flixage/ui/pages/unauthenticated/loading/splash_page.dart';
import 'package:flixage/ui/pages/unauthenticated/login/login_page.dart';
import 'package:flixage/ui/widget/bloc_provider.dart';
import 'package:flixage/ui/widget/cached_network_image/dio_cache_manager.dart';
import 'package:flixage/ui/widget/item/context_menu/album_context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/artist_context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/playlist_context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/track_context_menu.dart';
import 'package:flixage/ui/widget/named_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  static final Logger logger = Logger();

  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final unauthenticatedRoutes = {LoginPage.route: (_) => LoginPage()};

  final authenticatedRoutes = {
    AudioPlayerPage.route: (_) => AudioPlayerPage(),
    PickPlaylistPage.route: (_) => PickPlaylistPage(),
    LoggedMainPage.route: (_) => LoggedMainPage(),
    AlbumContextMenu.route: (_) => AlbumContextMenu(),
    TrackContextMenu.route: (_) => TrackContextMenu(),
    PlaylistContextMenu.route: (_) => PlaylistContextMenu(),
    ArtistContextMenu.route: (_) => ArtistContextMenu(),
  };

  GlobalKey<LoggedMainPageState> mainPageState;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AuthenticationBloc>(context);
    final dio = Provider.of<Dio>(context);
    final tokenStore = Provider.of<TokenStore>(context);

    return StreamBuilder<AuthenticationState>(
      stream: bloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;

        switch (state.runtimeType) {
          case AuthenticationAuthenticated:
            return MultiProvider(
              providers: [
                Provider<DioCacheManager>(
                  create: (_) => DioCacheManager(dio, Settings(cacheKey: "images")),
                ),
                BlocProvider<AudioPlayerBloc>(
                  create: (_) => AudioPlayerBloc(
                      TrackRepository(dio), AssetsAudioPlayer(), tokenStore),
                  lazy: false,
                ),
                ProxyProvider<NotificationBloc, LibraryBloc>(
                  update: (_, notificationBloc, __) =>
                      LibraryBloc(PlaylistRepository(dio), notificationBloc),
                ),
              ],
              child: NamedNavigator(
                name: NamedNavigator.root,
                initialRoute: LoggedMainPage.route,
                onGenerateRoute: (settings) => MaterialPageRoute(
                    settings: settings, builder: authenticatedRoutes[settings.name]),
              ),
            );
          case AuthenticationUnauthenticated:
            return NamedNavigator(
              name: NamedNavigator.root,
              initialRoute: LoginPage.route,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                    settings: settings, builder: unauthenticatedRoutes[settings.name]);
              },
            );
          default:
            return SplashPage();
        }
      },
    );
  }
}
