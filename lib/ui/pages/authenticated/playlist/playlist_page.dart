import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/page/playlist/playlist_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/ui/pages/authenticated/playlist/playlist_thumbnail.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/default_loading_bloc_widget.dart';
import 'package:flixage/ui/widget/queryable_app_bar.dart';
import 'package:flixage/ui/widget/item/context_menu/playlist_context_menu.dart';
import 'package:flixage/ui/widget/item/track_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatelessWidget {
  static const route = '/playlist';

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Playlist playlist =
        (ModalRoute.of(context).settings.arguments as Arguments).extra;

    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return DefaultLoadingBlocWidget<PlaylistBloc, List<Track>>(
      create: (context) =>
          PlaylistBloc(playlistRepository: PlaylistRepository(Provider.of<Dio>(context))),
      onInit: (context, bloc) => bloc.dispatch(Load(arg: playlist)),
      builder: (context, _, tracks) {
        Widget body;

        if (tracks.isEmpty) {
          body = Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  S.current.playlistPage_emptyPlaylist,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 24),
                ),
              ],
            ),
          );
        } else {
          body = ListView.separated(
            shrinkWrap: true,
            controller: scrollController,
            padding: EdgeInsets.only(left: 8, top: 24, bottom: 8),
            separatorBuilder: (context, index) => SizedBox(height: 2),
            itemCount: tracks.length,
            itemBuilder: (context, index) => GestureDetector(
              child: TrackItem(track: tracks[index]),
              onTap: () => audioPlayerBloc.dispatch(PlayPlaylist(
                playlist: playlist,
                tracks: tracks,
                startIndex: index,
              )),
            ),
          );
        }

        return NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              QueryableAppBar(
                queryable: playlist,
                secondaryText: S.current.playlistPage_author(playlist.owner.name),
                contextMenuRoute: PlaylistContextMenu.route,
                showRandomButton: true,
                onRandomButtonTap: () => audioPlayerBloc.dispatch(
                  PlayPlaylist(
                      playlist: playlist, playMode: PlayMode.random, tracks: tracks),
                ),
                imageBuilder: (url, size) =>
                    PlaylistThumbnail(playlist: playlist, size: size),
              ),
            ];
          },
          body: body,
        );
      },
    );
  }
}
