import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/ui/pages/routes/audio_player/audio_player.dart';
import 'package:flixage/ui/pages/routes/audio_player/subcomponent/audio_player_state_button.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/named_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flixage/ui/widget/reroute_request.dart';

class AudioPlayerWidget extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const AudioPlayerWidget({Key key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<Track>(
      stream: bloc.audio,
      builder: (context, audioSnapshot) {
        if (!audioSnapshot.hasData) {
          return Container();
        }

        final audio = audioSnapshot.data;
        final screenWidth = MediaQuery.of(context).size.width;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => handleReroute(
            navigatorKey.currentState,
            NamedNavigator.of(context, NamedNavigator.root)
                .pushNamed(AudioPlayerPage.route),
          ),
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
                          value: duration.inSeconds / audio.duration.inSeconds));
                },
              ),
              Container(
                width: screenWidth,
                height: 64,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Image is a rectangle she we will use height as width
                    CustomImage(imageUrl: audio.thumbnailUrl, width: 64, height: 64),
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
                                  Text(audio.artist.name)
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
