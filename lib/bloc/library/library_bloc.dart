import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/library/library_event.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

class LibraryBloc extends Bloc<LibraryEvent> {
  static final log = Logger();

  final BehaviorSubject<List<Playlist>> _playlistsSubject = BehaviorSubject();

  final PlaylistRepository playlistRepository;
  final NotificationBloc notificationBloc;

  Stream<List<Playlist>> get playlists => _playlistsSubject.stream;

  LibraryBloc(this.playlistRepository, this.notificationBloc);

  @override
  void onEvent(LibraryEvent event) async {
    if (event is FetchLibrary) {
      playlistRepository.getCurrentUserPlaylists().then((playlists) {
        _playlistsSubject.add(playlists);
      }).catchError((error) {
        notificationBloc
            .dispatch(SimpleNotification.error(content: S.current.libraryFetchError));
      });
    } else if (event is CreatePlaylist) {
      playlistRepository.create({'name': event.name}).then((playlist) {
        _playlistsSubject.add(_getPlaylists..add(playlist));
        notificationBloc.dispatch(
            SimpleNotification.info(content: S.current.playlistCreated(playlist.name)));
      }).catchError((e) {
        notificationBloc
            .dispatch(SimpleNotification.error(content: S.current.playlistCreateError));
      });
    } else if (event is UpdatePlaylist) {
      playlistRepository.update(event.playlist.id, event.playlist).then((playlist) {
        _playlistsSubject.add(_getPlaylists
          ..removeWhere((playlist) => playlist.id == event.playlist.id)
          ..add(event.playlist));

        notificationBloc.dispatch(
            SimpleNotification.info(content: S.current.playlistUpdated(playlist.name)));
      }).catchError((e) {
        notificationBloc
            .dispatch(SimpleNotification.error(content: S.current.playlistUpdateError));
      });
    } else if (event is DeletePlaylist) {
      playlistRepository.delete(event.playlist.id).then((_) {
        _playlistsSubject.add(_getPlaylists..remove(event.playlist));
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

  @override
  void dispose() {
    _playlistsSubject.close();
  }

  List<Playlist> get _getPlaylists =>
      _playlistsSubject.hasValue ? _playlistsSubject.value : List();
}
