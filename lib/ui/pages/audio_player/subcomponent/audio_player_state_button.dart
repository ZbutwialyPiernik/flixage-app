import 'package:flixage/bloc/audio_player_bloc.dart';
import 'package:flixage/model/enum/player_state.dart';
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
      stream: bloc.playerState,
      builder: (context, state) {
        IconData icon = state.data == PlayerState.Playing ? pauseIcon : playIcon;

        var nextState =
            state.data == PlayerState.Playing ? PlayerState.Paused : PlayerState.Playing;

        return IconButton(
            icon: Icon(icon),
            iconSize: iconSize,
            onPressed: () =>
                bloc.dispatch(new ChangePlayerStateEvent(playerState: nextState)));
      },
    );
  }
}
