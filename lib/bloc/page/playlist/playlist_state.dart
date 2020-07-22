import 'package:equatable/equatable.dart';
import 'package:flixage/model/track.dart';

abstract class PlaylistLoadingState extends Equatable {
  PlaylistLoadingState();

  @override
  List<Object> get props => [];
}

class PlaylistLoadingSuccess extends PlaylistLoadingState {
  final List<Track> tracks;

  PlaylistLoadingSuccess(this.tracks);
}

class PlaylistLoadingError extends PlaylistLoadingState {
  final String error;

  PlaylistLoadingError(this.error);

  @override
  List<Object> get props => [error];
}
