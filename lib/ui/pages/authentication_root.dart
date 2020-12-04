import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dio/dio.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/page/library/follow_playlist_bloc.dart';
import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/token_store.dart';
import 'package:flixage/repository/album_repository.dart';
import 'package:flixage/repository/artist_repository.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/repository/search_repository.dart';
import 'package:flixage/repository/track_repository.dart';
import 'package:flixage/ui/bloc_util.dart';
import 'package:flixage/ui/pages/authenticated/authenticated_main_page.dart';
import 'package:flixage/ui/pages/unauthenticated/loading/splash_page.dart';
import 'package:flixage/ui/pages/unauthenticated/unauthenticated_main_page.dart';
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
    final tokenStore = Provider.of<TokenStore>(context);

    return StreamBuilder<AuthenticationState>(
      stream: bloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;

        switch (state.runtimeType) {
          case AuthenticationAuthenticated:
            return MultiProvider(providers: [
              repositoryProvider<PlaylistRepository>((dio) => PlaylistRepository(dio)),
              repositoryProvider<AlbumRepository>((dio) => AlbumRepository(dio)),
              repositoryProvider<SearchRepository>((dio) => SearchRepository(dio)),
              repositoryProvider<TrackRepository>((dio) => TrackRepository(dio)),
              repositoryProvider<ArtistRepository>((dio) => ArtistRepository(dio)),
              ProxyProvider<Dio, DioCacheManager>(
                update: (_, dio, __) =>
                    DioCacheManager(dio, Settings(cacheKey: "images")),
              ),
              ProxyProvider<TrackRepository, AudioPlayerBloc>(
                update: (_, trackRepository, __) =>
                    AudioPlayerBloc(trackRepository, AssetsAudioPlayer(), tokenStore),
                lazy: false,
              ),
              ProxyProvider2<NotificationBloc, PlaylistRepository, LibraryBloc>(
                update: (_, notificationBloc, playlistRepository, __) =>
                    LibraryBloc(playlistRepository, notificationBloc),
              ),
              ProxyProvider<PlaylistRepository, FollowPlaylistBloc>(
                update: (_, playlistRepository, __) =>
                    FollowPlaylistBloc(playlistRepository: playlistRepository),
              )
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
