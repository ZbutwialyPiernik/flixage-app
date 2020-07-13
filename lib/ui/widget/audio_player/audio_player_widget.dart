import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/ui/pages/authenticated/audio_player/audio_player.dart';
import 'package:flixage/ui/pages/authenticated/audio_player/subcomponent/audio_player_state_button.dart';
import 'package:flixage/ui/pages/authenticated/page_settings.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerWidget extends StatelessWidget {
  final NavigatorState navigator;

  const AudioPlayerWidget({Key key, this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<Track>(
      stream: bloc.audio,
      builder: (context, audioSnapshot) {
        if (!audioSnapshot.hasData) {
          return Container();
        }

        final track = audioSnapshot.data;
        final screenWidth = MediaQuery.of(context).size.width;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => navigator.pushNamed(AudioPlayerPage.route,
              arguments: Arguments(showBottomAppBar: false)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              StreamBuilder<Duration>(
                stream: bloc.currentPosition,
                builder: (context, durationSnapshot) {
                  final duration = durationSnapshot.data ?? Duration.zero;

                  return SizedBox(
                      width: screenWidth,
                      height: 2,
                      child: LinearProgressIndicator(
                          backgroundColor: Colors.white30,
                          value: duration.inSeconds / track.duration.inSeconds));
                },
              ),
              Container(
                width: screenWidth,
                height: 64,
                color: Theme.of(context).bottomAppBarColor,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Image is a rectangle she we will use height as width
                    CustomImage(imageUrl: track.thumbnailUrl, width: 64, height: 64),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: <Widget>[
                                  Text(track.name,
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(" | "),
                                  Text(track.artist.name)
                                ],
                              )),
                          AudioPlayerStateButton(
                            bloc: bloc,
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
