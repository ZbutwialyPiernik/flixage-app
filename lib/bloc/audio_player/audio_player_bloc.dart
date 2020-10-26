import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart' as player;
import 'package:flixage/bloc/audio_player/audio_player_counter.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/token_store.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/track_repository.dart';
import 'package:flixage/util/constants.dart';
import 'package:rxdart/rxdart.dart';

import 'audio_player_event.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, player.PlayerState> {
  final BehaviorSubject<Track> _audioSubject = BehaviorSubject<Track>();
  final BehaviorSubject<Playlist> _playlistSubject = BehaviorSubject<Playlist>();
  final BehaviorSubject<PlayMode> _playModeSubject =
      BehaviorSubject<PlayMode>.seeded(PlayMode.normal);

  @override
  Stream<player.PlayerState> get state => _audioPlayer.playerState;
  Stream<player.LoopMode> get loopMode => _audioPlayer.loopMode;
  Stream<Track> get audio => _audioSubject.stream;
  Stream<Duration> get currentPosition => _audioPlayer.currentPosition;
  Stream<PlayMode> get playMode => _playModeSubject.stream;

  double listeningDuration = 0;

  final player.AssetsAudioPlayer _audioPlayer;
  final TokenStore _tokenStore;
  final AudioPlayerCounter _audioPlayerCounter;

  AudioPlayerBloc(TrackRepository trackRepository, this._audioPlayer, this._tokenStore)
      : this._audioPlayerCounter = AudioPlayerCounter(_audioPlayer, trackRepository) {
    _tokenStore.getAccessToken().then((token) => _audioPlayer.networkSettings
        .defaultHeaders[HttpHeaders.authorizationHeader] = "Bearer " + token);

    _audioPlayer.onErrorDo = (handler) async {
      /*var oldAudio = handler.playlist.audios[handler.playlistIndex];
        var newAudio = oldAudio.copyWith(headers: {
          HttpHeaders.authorizationHeader: "Bearer " + await _tokenStore.getAccessToken()
        });

        handler.playlist.audios[handler.playlistIndex] = newAudio;
        dispatch(ChangePlayerState(playerState: player.PlayerState.play));*/

      dispatch(ChangePlayerState(playerState: player.PlayerState.pause));
    };
  }

  @override
  void onEvent(AudioPlayerEvent event) async {
    if (event is PlayableEvent) {
      _audioPlayer.shuffle = event.playMode == PlayMode.random;

      if (event.selectedTrack.id == _audioSubject.value?.id) {
        return;
      }

      _audioSubject.add(event.selectedTrack);

      if (event is PlayPlaylist) {
        if (_playlistSubject.value.id == event.playlist.id) {
          _audioPlayer.playlistPlayAtIndex(event.startIndex);
          return;
        }

        _playlistSubject.add(event.playlist);
      } else {
        _playlistSubject.add(null);
      }

      final accessToken = await _tokenStore.getAccessToken();

      final playlist = player.Playlist(
          audios: event.tracks.map((track) => toNetwork(track, accessToken)).toList(),
          startIndex: event.startIndex);

      _audioPlayer.open(playlist, showNotification: true);
    } else if (event is PlayNextEvent) {
      _audioPlayer.next();
    } else if (event is PlayPreviousEvent) {
      _audioPlayer.previous();
    } else if (event is ChangePlayerState) {
      if (_audioPlayer.playerState.value == event.playerState) {
        return;
      }

      switch (event.playerState) {
        case player.PlayerState.play:
          {
            _audioPlayer.play();
          }
          break;
        case player.PlayerState.pause:
          {
            _audioPlayer.pause();
          }
          break;
        case player.PlayerState.stop:
          {
            _audioPlayer.stop();
          }
          break;
      }
    } else if (event is TogglePlaybackMode) {
      player.LoopMode currentLoopMode = _audioPlayer.currentLoopMode;
      player.LoopMode nextLoopMode;

      if (currentLoopMode == player.LoopMode.values.last) {
        nextLoopMode = player.LoopMode.values.first;
      } else {
        nextLoopMode =
            player.LoopMode.values[player.LoopMode.values.indexOf(currentLoopMode) + 1];
      }

      _audioPlayer.setLoopMode(nextLoopMode);
    } else if (event is TogglePlayMode) {
      if (_playModeSubject.value == PlayMode.random) {
        _playModeSubject.add(PlayMode.normal);
      } else {
        _playModeSubject.add(PlayMode.random);
      }
    } else if (event is RewindEvent) {
      if (_audioPlayer.playerState.value != player.PlayerState.stop) {
        _audioPlayer.seek(event.duration);
      }
    }
  }

  player.Audio toNetwork(Track track, String accessToken) => player.Audio.network(
      API_SERVER + "/tracks/${track.id}/stream",
      headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken},
      metas: player.Metas(artist: track.artist.name, title: track.name, id: track.id));

  @override
  void dispose() {
    _playlistSubject.close();
    _audioSubject.close();
    _audioPlayer.dispose();
  }
}
