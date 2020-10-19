import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:logger/logger.dart';

class LoadPlaylist extends Equatable {
  final Playlist playlist;

  LoadPlaylist(this.playlist);

  @override
  List<Object> get props => [playlist];
}

class PlaylistBloc extends LoadingBloc<LoadPlaylist, List<Track>> {
  final Logger log = Logger();
  final PlaylistRepository playlistRepository;

  PlaylistBloc({
    this.playlistRepository,
  });

  @override
  Future<List<Track>> load(LoadPlaylist event) async {
    try {
      final tracks = await playlistRepository.getTracksFromPlaylist(event.playlist.id);

      return tracks;
    } catch (e) {
      return Future.error(S.current.playlistPage_playlistLoadingError);
    }
  }
}
