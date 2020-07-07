import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:equatable/equatable.dart';
import 'package:flixage/model/playlist.dart' as flixage;
import 'package:flixage/model/track.dart';
import 'package:meta/meta.dart';

enum PlayMode { normal, random }

abstract class AudioPlayerEvent extends Equatable {
  List<Object> get props => [];
}

class PlayNextEvent extends AudioPlayerEvent {}

class PlayPreviousEvent extends AudioPlayerEvent {}

abstract class PlayableEvent extends AudioPlayerEvent {
  final List<Track> tracks;
  final int startIndex;
  final PlayMode playMode;

  PlayableEvent(this.tracks, this.startIndex, this.playMode);

  Track get selectedTrack => tracks[startIndex];
}

class PlayTrack extends PlayableEvent {
  PlayTrack({Track track})
      : assert(track != null),
        super([track], 0, PlayMode.normal);
}

class PlayTracks extends PlayableEvent {
  PlayTracks({@required List<Track> tracks, startIndex = 0, playMode = PlayMode.normal})
      : assert(startIndex != null),
        assert(tracks != null),
        super(tracks, startIndex, playMode);
}

class PlayPlaylist extends PlayTracks {
  final flixage.Playlist playlist;

  PlayPlaylist(
      {@required this.playlist,
      @required List<Track> tracks,
      startIndex = 0,
      playMode = PlayMode.normal})
      : super(tracks: tracks, startIndex: startIndex, playMode: playMode);
}

class ChangePlayerState extends AudioPlayerEvent {
  final PlayerState playerState;

  ChangePlayerState({this.playerState});
}

class TogglePlayMode extends AudioPlayerEvent {}

class TogglePlaybackMode extends AudioPlayerEvent {}

class RewindEvent extends AudioPlayerEvent {
  final Duration duration;

  RewindEvent({this.duration});
}
