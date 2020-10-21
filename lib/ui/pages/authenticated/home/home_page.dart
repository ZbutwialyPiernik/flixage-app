import 'package:dio/dio.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/bloc/page/home/home_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/queryable.dart';
import 'package:flixage/repository/album_repository.dart';
import 'package:flixage/repository/artist_repository.dart';
import 'package:flixage/repository/track_repository.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:flixage/ui/pages/authenticated/album/album_page.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/pages/authenticated/settings/settings_page.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/loading_widget.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String route = "home";

  @override
  Widget build(BuildContext context) {
    final dio = Provider.of<Dio>(context);

    final audioPlayer = Provider.of<AudioPlayerBloc>(context);
    final bloc = HomeBloc(
      albumRepository: AlbumRepository(dio),
      artistRepository: ArtistRepository(dio),
      trackRepository: TrackRepository(dio),
      userRepository: UserRepository(dio),
    );

    return StatefulWrapper(
      onInit: () => bloc.dispatch(LoadHome()),
      onDispose: () => bloc.dispose(),
      child: Column(
        children: [
          AppBar(
            title: Text("Flixage"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed(SettingsPage.route);
                },
              ),
            ],
          ),
          _buildPageContent(bloc, audioPlayer),
        ],
      ),
    );
  }

  Widget _buildPageContent(HomeBloc bloc, AudioPlayerBloc audioPlayer) {
    return StreamBuilder<HomeData>(
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingWidget();
        }

        final data = snapshot.data;

        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (data.recentlyListened.isNotEmpty)
                ..._buildSection(
                  context,
                  title: S.current.homePage_recentlyPlayed,
                  items: data.recentlyListened,
                  onTap: (track) => audioPlayer.dispatch(PlayTrack(track: track)),
                ),
              ..._buildSection(
                context,
                title: S.current.homePage_newReleases,
                items: data.recentlyAddedAlbums,
                onTap: (album) => Navigator.of(context).pushNamed(
                  AlbumPage.route,
                  arguments: Arguments(extra: album),
                ),
              ),
              /*
                ..._buildSection(
                  context,
                  title: S.current.homePage_latestSingles,
                  items: data.recentlyAddedTracks,
                  onTap: (track) => audioPlayer.dispatch(PlayTrack(track: track)),
                ),*/
              /*
                ..._buildSection(
                  context,
                  title: S.current.homePage_latestArtists,
                  items: data.recentlyAddedArists,
                  onTap: (artist) => Navigator.of(context).pushNamed(
                    ArtistPage.route,
                    arguments: Arguments(extra: artist),
                  ),
                ),*/
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildSection<T extends Queryable>(
    BuildContext context, {
    @required String title,
    @required List<T> items,
    @required Function(T) onTap,
  }) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16, right: 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      Container(
        height: 172,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 8),
          itemBuilder: (context, index) => _buildItem(context, items[index], onTap),
          separatorBuilder: (context, index) => SizedBox(width: 16),
          itemCount: items.length,
        ),
      ),
    ];
  }

  Widget _buildItem<T extends Queryable>(
      BuildContext context, Queryable queryable, Function(T) onTap) {
    return GestureDetector(
      onTap: () => onTap(queryable),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomImage(
            imageUrl: queryable.thumbnailUrl,
            height: 144,
            width: 144,
          ),
          Text(
            queryable.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
