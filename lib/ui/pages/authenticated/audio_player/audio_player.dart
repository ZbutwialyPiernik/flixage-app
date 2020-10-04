import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/ui/pages/authenticated/artist/artist_page.dart';
import 'package:flixage/ui/pages/authenticated/audio_player/audio_player_slider.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/pages/authenticated/audio_player/subcomponent/audio_player_state_button.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_button.dart';
import 'package:flixage/ui/widget/item/context_menu/track_context_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerPage extends StatelessWidget {
  static const String route = "audioPlayer";

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final bloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<Track>(
      stream: bloc.audio,
      builder: (context, snapshot) {
        final track = snapshot.data;

        if (!snapshot.hasData) {
          return Container();
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: () => Navigator.of(context).pop()),
                ContextMenuButton(route: TrackContextMenu.route, item: track)
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width - 24 * 2,
              height: MediaQuery.of(context).size.width - 24 * 2,
              margin: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 1),
                  )
                ],
              ),
              child: CustomImage(
                imageUrl: track.thumbnailUrl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            track.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontSize: 22.0),
                          ),
                          InkWell(
                            child: Text(track.artist.name,
                                style: TextStyle(color: Colors.white.withOpacity(0.6))),
                            onTap: () => Navigator.of(context).popAndPushNamed(
                                ArtistPage.route,
                                arguments: Arguments(extra: track.artist)),
                          ),
                        ],
                      ),
                      IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
                    ],
                  ),
                  AudioPlayerSlider(
                    track: track,
                    playerState: bloc.playerState,
                    currentPosition: bloc.currentPosition,
                    builder: (context, track, progress) {
                      return Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white.withOpacity(0.1),
                              trackHeight: 3.0,
                              thumbColor: Colors.white,
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.0),
                              trackShape: CustomTrackShape(),
                              overlayColor: Colors.purple.withAlpha(32),
                              overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
                            ),
                            child: Slider(
                              min: 0,
                              max: track != null
                                  ? track.duration.inMilliseconds.toDouble()
                                  : 100,
                              value: progress * track.duration.inMilliseconds.toDouble(),
                              onChanged: (value) {
                                bloc.dispatch(RewindEvent(
                                    duration: Duration(milliseconds: value.toInt())));
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(durationToString(Duration(
                                  seconds:
                                      (track.duration.inSeconds * progress).toInt()))),
                              Text(
                                durationToString(
                                    track != null ? track.duration : Duration.zero),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      StreamBuilder<PlayMode>(
                        stream: bloc.playMode,
                        builder: (context, snapshot) {
                          return IconButton(
                            iconSize: 24,
                            icon: Icon(Icons.shuffle),
                            color: snapshot.data == PlayMode.random
                                ? Theme.of(context).accentColor
                                : null,
                            onPressed: () => bloc.dispatch(new TogglePlayMode()),
                          );
                        },
                      ),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          iconSize: 32,
                          icon: Icon(Icons.skip_previous),
                          onPressed: () => bloc.dispatch(PlayPreviousEvent())),
                      AudioPlayerStateButton(
                          bloc: bloc,
                          iconSize: 64,
                          playIcon: Icons.play_circle_filled,
                          pauseIcon: Icons.pause_circle_filled),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          iconSize: 32,
                          icon: Icon(Icons.skip_next),
                          onPressed: () => bloc.dispatch(PlayNextEvent())),
                      StreamBuilder<LoopMode>(
                        stream: bloc.loopMode,
                        builder: (context, snapshot) {
                          Icon icon;
                          switch (snapshot.data) {
                            case LoopMode.single:
                              icon = Icon(Icons.repeat_one,
                                  color: Theme.of(context).accentColor);
                              break;
                            case LoopMode.playlist:
                              icon = Icon(Icons.repeat,
                                  color: Theme.of(context).accentColor);
                              break;
                            default:
                              icon = Icon(Icons.repeat);
                              break;
                          }

                          return IconButton(
                            iconSize: 24,
                            padding: EdgeInsets.all(0),
                            icon: icon,
                            onPressed: () => bloc.dispatch(
                              new TogglePlaybackMode(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  String durationToString(Duration duration) {
    String seconds;

    if (duration.inSeconds % 60 < 10) {
      seconds = "0${(duration.inSeconds % 60).toString()}";
    } else {
      seconds = (duration.inSeconds % 60).toString();
    }

    return "${duration.inMinutes}:$seconds";
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
