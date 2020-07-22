import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dio/dio.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/token_store.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/repository/track_repository.dart';
import 'package:flixage/ui/pages/authenticated/authenticated_main_page.dart';
import 'package:flixage/ui/pages/unauthenticated/loading/splash_page.dart';
import 'package:flixage/ui/pages/unauthenticated/unauthenticated_main_page.dart';
import 'package:flixage/ui/widget/bloc_provider.dart';
import 'package:flixage/ui/widget/cached_network_image/dio_cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AuthenticationRoot extends StatelessWidget {
  static final Logger logger = Logger();

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
            return MultiProvider(providers: [
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
            ], child: AuthenticatedMainPage());
          case AuthenticationUnauthenticated:
            return UnauthenticatedMainPage();
          default:
            return SplashPage();
        }
      },
    );
  }
}
