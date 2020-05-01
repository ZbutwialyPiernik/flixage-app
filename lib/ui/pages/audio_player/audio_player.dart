import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixage/bloc/audio_player_bloc.dart';
import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/model/enum/playback_mode.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/ui/item/context_menu/track_context_menu.dart';
import 'package:flixage/ui/pages/audio_player/audio_player_slider.dart';
import 'package:flixage/ui/pages/audio_player/subcomponent/audio_player_state_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerPage extends StatelessWidget {
  static const String route = "audioPlayer";

  @override
  Widget build(BuildContext context) {
    final AudioPlayerBloc _bloc = Provider.of<GlobalBloc>(context).audioPlayerBloc;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StreamBuilder<Track>(
                stream: _bloc.audio,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? _displaySongInfo(context, snapshot.data)
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
              AudioPlayerSlider(),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.shuffle),
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => _bloc.dispatch(PlayPreviousEvent())),
                      AudioPlayerStateButton(
                          bloc: _bloc,
                          iconSize: 48,
                          playIcon: Icons.play_circle_filled,
                          pauseIcon: Icons.pause_circle_filled),
                      IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () => _bloc.dispatch(PlayNextEvent())),
                      StreamBuilder<PlaybackMode>(
                        stream: _bloc.playbackMode,
                        builder: (context, snapshot) {
                          IconData icon = snapshot.data == PlaybackMode.Ordered
                              ? Icons.swap_horiz
                              : Icons.shuffle;

                          return IconButton(
                              icon: Icon(icon),
                              onPressed: () => _bloc.dispatch(new TogglePlaybackMode()));
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _displaySongInfo(BuildContext context, Track track) {
    final contextMenu = TrackContextMenu();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () => Navigator.of(context).pop()),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => contextMenu.open(context, track),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 8.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 1))
            ],
          ),
          child: CachedNetworkImage(
              imageUrl: track.thumbnailUrl,
              width: double.infinity,
              alignment: Alignment.center),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  track.name,
                  style: Theme.of(context).textTheme.title.copyWith(fontSize: 22.0),
                ),
                InkWell(
                    child: Text(track.artists[0].name,
                        style: TextStyle(color: Colors.white.withOpacity(0.6))),
                    onTap: () => print('XD')),
              ],
            ),
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
