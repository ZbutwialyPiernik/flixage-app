import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixage/bloc/audio_player_bloc.dart';
import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/bloc/playlist_bloc.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/item/context_menu/playlist_context_menu.dart';
import 'package:flixage/ui/item/track_item.dart';
import 'package:flixage/util/stateful_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatelessWidget {
  static const route = '/playlist';
  final contextMenu = PlaylistContextMenu();

  @override
  Widget build(BuildContext context) {
    final Playlist playlist = ModalRoute.of(context).settings.arguments;

    final PlaylistBloc playlistBloc = Provider.of<GlobalBloc>(context).playlistBloc;
    final AudioPlayerBloc audioPlayerBloc =
        Provider.of<GlobalBloc>(context).audioPlayerBloc;

    return StatefulWrapper(
      onInit: () => playlistBloc.dispatch(LoadTracks(playlist.id)),
      onDispose: () => playlistBloc.dispose(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop()),
                  IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () => contextMenu.open(context, playlist)),
                ],
              ),
              CachedNetworkImage(
                  imageUrl: playlist.thumbnailUrl, width: 128, height: 128),
              Text(playlist.name),
              StreamBuilder<TrackLoadingState>(
                builder: (context, snapshot) {
                  final state = snapshot.data;

                  if (state is TrackLoadingSuccess) {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          Divider(height: 2, color: Colors.transparent),
                      itemCount: state.tracks.length,
                      itemBuilder: (context, index) => GestureDetector(
                        child: TrackItem(track: state.tracks[index], height: 48),
                        onTap: () => audioPlayerBloc.dispatch(
                          PlayEvent(audio: state.tracks[index]),
                        ),
                      ),
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
