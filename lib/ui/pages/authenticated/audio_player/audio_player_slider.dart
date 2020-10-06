import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flixage/model/track.dart';
import 'package:flutter/material.dart';

class AudioPlayerSlider extends StatefulWidget {
  final Track track;
  final Stream<PlayerState> playerState;
  final Stream<Duration> currentPosition;
  final Widget Function(BuildContext context, Track track, double progress) builder;

  const AudioPlayerSlider({
    Key key,
    @required this.track,
    @required this.playerState,
    @required this.currentPosition,
    @required this.builder,
  }) : super(key: key);

  @override
  _AudioPlayerSliderState createState() => _AudioPlayerSliderState();
}

class _AudioPlayerSliderState extends State<AudioPlayerSlider>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  StreamSubscription<PlayerState> playerStateListener;
  StreamSubscription<Duration> currentPositionListener;

  Duration lastDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    playerStateListener = widget.playerState.listen((state) {
      if (state == PlayerState.play) {
        animationController.forward();
      } else {
        if (!animationController.isCompleted) {
          animationController.stop();
        }
      }
    });

    currentPositionListener = widget.currentPosition.listen((duration) {
      duration = duration ?? Duration.zero;

      if (duration.inSeconds != lastDuration.inSeconds) {
        animationController.value =
            duration.inMilliseconds / widget.track.duration.inMilliseconds;
        animationController.forward();
      }

      lastDuration = duration;
    });

    animationController =
        AnimationController(duration: widget.track.duration, vsync: this)
          ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, widget.track, animationController.value);

  @override
  void dispose() {
    super.dispose();
    playerStateListener.cancel();
    currentPositionListener.cancel();
    animationController.dispose();
  }
}
