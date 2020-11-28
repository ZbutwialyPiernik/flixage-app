import 'package:equatable/equatable.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';

abstract class LibraryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadLibrary extends LibraryEvent {}

class CreatePlaylist extends LibraryEvent {
  final String name;

  CreatePlaylist({this.name});

  @override
  List<Object> get props => [name];
}

class DeletePlaylist extends LibraryEvent {
  final Playlist playlist;

  DeletePlaylist({this.playlist});

  @override
  List<Object> get props => [playlist];
}

class UpdatePlaylist extends LibraryEvent {
  final Playlist playlist;

  UpdatePlaylist({this.playlist});

  @override
  List<Object> get props => [playlist];
}

class AddTracksToPlaylist extends LibraryEvent {
  final Playlist playlist;
  final List<Track> tracks;

  AddTracksToPlaylist({this.playlist, this.tracks});

  @override
  List<Object> get props => [playlist, tracks];
}

class RemoveTrackFromPlaylist extends LibraryEvent {
  final Playlist playlist;
  final Track track;

  RemoveTrackFromPlaylist({this.playlist, this.track});
}