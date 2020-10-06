import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flixage/model/playlist.dart';

abstract class PlaylistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTracks extends PlaylistEvent {
  final Playlist playlist;

  LoadTracks(this.playlist);

  @override
  List<Object> get props => [playlist];
}

class UploadThumbnail extends PlaylistEvent {
  final File image;
  final Playlist playlist;

  UploadThumbnail({this.image, this.playlist});

  @override
  List<Object> get props => [image, playlist];
}
