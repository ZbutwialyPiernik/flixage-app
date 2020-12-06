import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/page/library/library_event.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:logger/logger.dart';

class LibraryBloc extends AbstractLoadingBloc<void, List<Playlist>> {
  static final log = Logger();

  final PlaylistRepository playlistRepository;
  final NotificationBloc notificationBloc;

  LibraryBloc(this.playlistRepository, this.notificationBloc);

  @override
  void onEvent(AbstractLoad<void> event) async {
    if (event is LoadLibrary) {
      super.onEvent(event);
    } else if (event is CreatePlaylist) {
      playlistRepository.create({'name': event.name}).then((playlist) {
        subject.add(LoadingSuccess(_getPlaylists..add(playlist)));
        notificationBloc.dispatch(
            SimpleNotification.info(content: S.current.playlistCreated(playlist.name)));
      }).catchError((e) {
        notificationBloc.dispatch(
            SimpleNotification.error(content: S.current.playlistCreateError(event.name)));
      });
    } else if (event is UpdatePlaylist) {
      playlistRepository.update(event.playlist.id, event.playlist).then((playlist) {
        subject.add(LoadingSuccess(_getPlaylists
          ..removeWhere((playlist) => playlist.id == event.playlist.id)
          ..add(event.playlist)));

        notificationBloc.dispatch(
            SimpleNotification.info(content: S.current.playlistUpdated(playlist.name)));
      }).catchError((e) {
        notificationBloc.dispatch(SimpleNotification.error(
            content: S.current.playlistUpdateError(event.playlist.name)));
      });
    } else if (event is DeletePlaylist) {
      playlistRepository.delete(event.playlist.id).then((_) {
        subject.add(LoadingSuccess(_getPlaylists..remove(event.playlist)));
        notificationBloc.dispatch(SimpleNotification.info(
            content: S.current.playlistDeleted(event.playlist.name)));
      }).catchError((e) => notificationBloc.dispatch(SimpleNotification.error(
          content: S.current.playlistDeleteError(event.playlist.name))));
    } else if (event is AddTracksToPlaylist) {
      final trackIds = event.tracks.map((track) => track.id).toList();

      playlistRepository
          .addTracks(event.playlist.id, {"ids": trackIds})
          .then((value) => notificationBloc.dispatch(SimpleNotification.info(
              content: S.current.trackAdded(event.playlist.name))))
          .catchError((e) => notificationBloc.dispatch(SimpleNotification.error(
              content: S.current.trackAddError(event.playlist.name))));
    }
  }

  List<Playlist> get _getPlaylists =>
      subject.value is LoadingSuccess ? subject.value : List();

  @override
  Future<List<Playlist>> load(void _) {
    try {
      return playlistRepository.getCurrentUserPlaylists();
    } catch (error) {
      return Future.error(S.current.libraryFetchError);
    }
  }
}
