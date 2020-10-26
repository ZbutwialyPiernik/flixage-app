import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioPlayerStateButton extends StatelessWidget {
  final AudioPlayerBloc bloc;
  final double iconSize;
  final IconData pauseIcon;
  final IconData playIcon;

  const AudioPlayerStateButton(
      {Key key,
      @required this.bloc,
      @required this.iconSize,
      this.pauseIcon,
      this.playIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: bloc.state,
      builder: (context, state) {
        IconData icon = state.data == PlayerState.play ? pauseIcon : playIcon;

        var nextState =
            state.data == PlayerState.play ? PlayerState.pause : PlayerState.play;

        return IconButton(
            icon: Icon(icon),
            iconSize: iconSize,
            onPressed: () => bloc.dispatch(ChangePlayerState(playerState: nextState)));
      },
    );
  }
}
