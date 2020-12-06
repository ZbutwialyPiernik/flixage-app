import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:meta/meta.dart';

class LoadPlaylistBloc extends AbstractLoadingBloc<String, Playlist> {
  final PlaylistRepository playlistRepository;

  LoadPlaylistBloc({
    @required this.playlistRepository,
  });

  @override
  Future<Playlist> load(String id) async {
    try {
      return await playlistRepository.getById(id);
    } catch (e) {
      return Future.error(S.current.playlistPage_playlistLoadingError);
    }
  }
}
