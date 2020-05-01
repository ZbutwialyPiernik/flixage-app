import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/model/enum/playback_mode.dart';
import 'package:flixage/model/enum/player_state.dart';
import 'package:flixage/model/track.dart';
import 'package:rxdart/rxdart.dart';

class MusicPlayerEvent {}

class PlayNextEvent extends MusicPlayerEvent {}

class PlayPreviousEvent extends MusicPlayerEvent {}

class PlayEvent extends MusicPlayerEvent {
  final Track audio;

  PlayEvent({this.audio});
}

class ChangePlayerStateEvent extends MusicPlayerEvent {
  final PlayerState playerState;

  ChangePlayerStateEvent({this.playerState});
}

class TogglePlaybackMode extends MusicPlayerEvent {}

class RewindEvent extends MusicPlayerEvent {
  final Duration duration;

  RewindEvent({this.duration});
}

class AudioPlayerBloc extends Bloc<MusicPlayerEvent> {
  final BehaviorSubject<PlaybackMode> _playbackModeSubject =
      BehaviorSubject<PlaybackMode>.seeded(PlaybackMode.Ordered);
  final BehaviorSubject<PlayerState> _playerStateSubject =
      BehaviorSubject<PlayerState>.seeded(PlayerState.Playing);
  final BehaviorSubject<Track> _audioSubject = BehaviorSubject<Track>();
  final BehaviorSubject<Duration> _audioPositionSubject =
      BehaviorSubject<Duration>.seeded(Duration.zero);

  Stream<PlaybackMode> get playbackMode => _playbackModeSubject.stream;
  Stream<PlayerState> get playerState => _playerStateSubject.stream;
  Stream<Track> get audio => _audioSubject.stream;
  Stream<Duration> get currentPosition => _audioPositionSubject.stream;

  final AudioPlayer _audioPlayer;

  AudioPlayerBloc(this._audioPlayer) {
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      _audioPositionSubject.add(duration);
    });
  }

  @override
  void onEvent(MusicPlayerEvent event) {
    if (event is PlayEvent) {
      _audioSubject.add(event.audio);
      _audioPositionSubject.add(Duration.zero);
      _playerStateSubject.add(PlayerState.Playing);
      _audioPlayer.play(event.audio.fileUrl);
    } else if (event is PlayNextEvent) {
    } else if (event is PlayPreviousEvent) {
    } else if (event is ChangePlayerStateEvent) {
      if (_playerStateSubject.value == event.playerState) {
        return;
      }

      switch (event.playerState) {
        case PlayerState.Playing:
          {
            _audioPlayer.play(_audioSubject.value.fileUrl);
          }
          break;
        case PlayerState.Paused:
          {
            _audioPlayer.pause();
          }
          break;
        case PlayerState.Stoppped:
          {
            _audioPlayer.stop();
          }
          break;
      }

      _playerStateSubject.add(event.playerState);
    } else if (event is TogglePlaybackMode) {
      PlaybackMode currentPlaybackMode = _playbackModeSubject.value;
      PlaybackMode nextPlaybackMode;

      if (currentPlaybackMode == PlaybackMode.values.last) {
        nextPlaybackMode = PlaybackMode.values.first;
      } else {
        nextPlaybackMode =
            PlaybackMode.values[PlaybackMode.values.indexOf(currentPlaybackMode) + 1];
      }

      _playbackModeSubject.sink.add(nextPlaybackMode);
    } else if (event is RewindEvent) {
      if (_audioPlayer.state == AudioPlayerState.PLAYING ||
          _audioPlayer.state == AudioPlayerState.PAUSED)
        _audioPlayer.seek(event.duration);
    }
  }

  @override
  void dispose() {
    _playerStateSubject.close();
    _playbackModeSubject.close();
    _audioSubject.close();
    _audioPlayer.dispose();
  }
}
