import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

class UploadThumbnail extends AbstractLoad<UploadThumbnail> {
  final File image;
  final Playlist playlist;

  UploadThumbnail({this.image, this.playlist});

  @override
  List<Object> get props => [image, playlist];

  @override
  UploadThumbnail get arg => this;
}

class ThumbnailUploaded extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaylistThumbnailBloc
    extends AbstractLoadingBloc<UploadThumbnail, ThumbnailUploaded> {
  static const supportedExtensions = [".jpg", ".png", ".jpeg"];

  final PlaylistRepository playlistRepository;

  PlaylistThumbnailBloc({
    @required this.playlistRepository,
  });

  @override
  Future<ThumbnailUploaded> load(UploadThumbnail event) async {
    final extension = p.extension(event.image.path);

    if (!supportedExtensions.contains(extension)) {
      return Future.error(S.current.playlistPage_unsupportedExtension);
    }

    try {
      await playlistRepository.uploadThumbnail(event.playlist.id, event.image);

      return ThumbnailUploaded();
    } catch (error) {
      return Future.error("Problem with uploading thumbnail");
    }
  }
}
