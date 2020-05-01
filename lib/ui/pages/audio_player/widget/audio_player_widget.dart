import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixage/bloc/audio_player_bloc.dart';
import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/ui/pages/audio_player/audio_player.dart';
import 'package:flixage/ui/pages/audio_player/subcomponent/audio_player_state_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerWidget extends StatelessWidget {
  final AudioPlayerBloc audioPlayerBloc;

  const AudioPlayerWidget({Key key, this.audioPlayerBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioPlayerBloc _bloc = Provider.of<GlobalBloc>(context).audioPlayerBloc;

    return StreamBuilder<Track>(
      stream: _bloc.audio,
      builder: (context, audioSnapshot) {
        if (!audioSnapshot.hasData) {
          return Container(width: 0, height: 0);
        }

        final audio = audioSnapshot.data;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () =>
              Navigator.of(context, rootNavigator: true).pushNamed(AudioPlayerPage.route),
          child: Column(
            children: <Widget>[
              StreamBuilder<Duration>(
                stream: _bloc.currentPosition,
                builder: (context, durationSnapshot) {
                  final duration =
                      durationSnapshot.hasData ? durationSnapshot.data : Duration.zero;

                  return SizedBox(
                      height: 2,
                      child: LinearProgressIndicator(
                          backgroundColor: Colors.white30,
                          value: duration.inSeconds / audio.duration));
                },
              ),
              Container(
                width: double.infinity,
                height: 64,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Image is a rectangle she we will use height as width
                    CachedNetworkImage(
                        imageUrl: audio.thumbnailUrl, width: 64, height: 64),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: <Widget>[
                                  Text(audio.name,
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(" | "),
                                  Text(audio.artists[0].name)
                                ],
                              )),
                          AudioPlayerStateButton(
                            bloc: _bloc,
                            iconSize: 24,
                            playIcon: Icons.play_arrow,
                            pauseIcon: Icons.pause,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
