import 'package:flixage/bloc/audio_player_bloc.dart';
import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/model/track.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AudioPlayerBloc _bloc = Provider.of<GlobalBloc>(context).audioPlayerBloc;

    return StreamBuilder<Track>(
      stream: _bloc.audio,
      builder: (context, audioState) {
        return StreamBuilder<Duration>(
          stream: _bloc.currentPosition,
          builder: (context, snapshot) {
            Duration duration = snapshot.hasData ? snapshot.data : Duration(seconds: 0);

            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white.withOpacity(0.1),
                trackHeight: 3.0,
                thumbColor: Colors.white,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.0),
                overlayColor: Colors.purple.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
              ),
              child: Slider(
                min: 0,
                max: audioState.hasData ? audioState.data.duration : 100,
                value: duration.inSeconds.toDouble(),
                onChanged: (value) {
                  _bloc.dispatch(RewindEvent(duration: Duration(seconds: value.toInt())));
                },
              ),
            );
          },
        );
      },
    );
  }
}
