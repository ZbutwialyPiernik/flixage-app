import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:logger/logger.dart';

class PlaylistBloc extends AbstractLoadingBloc<Playlist, List<Track>> {
  final Logger log = Logger();
  final PlaylistRepository playlistRepository;

  PlaylistBloc({
    this.playlistRepository,
  });

  @override
  Future<List<Track>> load(Playlist playlist) async {
    try {
      final tracks = await playlistRepository.getTracksFromPlaylist(playlist.id);

      return tracks;
    } catch (e) {
      return Future.error(S.current.playlistPage_playlistLoadingError);
    }
  }
}
