import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/playlist/playlist_bloc.dart';
import 'package:flixage/bloc/playlist/playlist_event.dart';
import 'package:flixage/bloc/playlist/playlist_state.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/ui/widget/queryable_app_bar.dart';
import 'package:flixage/ui/widget/item/context_menu/playlist_context_menu.dart';
import 'package:flixage/ui/widget/item/track_item.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatelessWidget {
  static const route = '/playlist';

  @override
  Widget build(BuildContext context) {
    final Playlist playlist = ModalRoute.of(context).settings.arguments;

    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);
    final notificationBloc = Provider.of<NotificationBloc>(context);
    final dio = Provider.of<Dio>(context);

    PlaylistBloc playlistBloc = PlaylistBloc(
        playlistRepository: PlaylistRepository(dio), notificationBloc: notificationBloc);

    return StatefulWrapper(
      onInit: () => playlistBloc.dispatch(LoadTracks(playlist)),
      onDispose: () => playlistBloc.dispose(),
      child: Material(
        color: Theme.of(context).backgroundColor,
        child: StreamBuilder<PlaylistLoadingState>(
          stream: playlistBloc.trackStream,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state is PlaylistLoadingSuccess)
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    QueryableAppBar(
                      queryable: playlist,
                      secondaryText: "Wykonawcy ${playlist.owner.name}",
                      contextMenuRoute: PlaylistContextMenu.route,
                      showRandomButton: true,
                      onRandomButtonTap: () => audioPlayerBloc.dispatch(
                        PlayPlaylist(
                            playlist: playlist,
                            playMode: PlayMode.random,
                            tracks: state.tracks),
                      ),
                    ),
                  ];
                },
                body: state.tracks.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Twoja playlista jest pusta",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        controller: PrimaryScrollController.of(context),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => SizedBox(height: 2),
                              itemCount: state.tracks.length,
                              itemBuilder: (context, index) => GestureDetector(
                                child: TrackItem(track: state.tracks[index]),
                                onTap: () => audioPlayerBloc.dispatch(
                                  PlayPlaylist(
                                      playlist: playlist,
                                      tracks: state.tracks,
                                      startIndex: index),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              );

            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
