import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/model/track.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerSlider extends StatelessWidget {
  final Track track;

  const AudioPlayerSlider({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<Duration>(
      stream: bloc.currentPosition,
      builder: (context, snapshot) {
        final duration = snapshot.hasData ? snapshot.data : Duration(seconds: 0);

        return Column(
          children: [
            TweenAnimationBuilder(
              tween: Tween<Duration>(begin: duration, end: track.duration),
              duration: Duration(
                  microseconds: track.duration.inMicroseconds - duration.inMicroseconds),
              builder: (context, Duration progress, _) {
                print(progress);
                print(track.duration);

                return SliderTheme(
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
                    max: track != null ? track.duration.inMilliseconds.toDouble() : 100,
                    value: progress.inMilliseconds.toDouble(),
                    onChanged: (value) {
                      bloc.dispatch(
                          RewindEvent(duration: Duration(milliseconds: value.toInt())));
                    },
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(durationToString(duration)),
                Text(durationToString(track != null ? track.duration : "0.00"))
              ],
            ),
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
