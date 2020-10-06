import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/page/playlist/playlist_event.dart';
import 'package:flixage/bloc/page/playlist/playlist_state.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as p;
import 'package:mime_type/mime_type.dart' as mime;

class PlaylistBloc extends Bloc<PlaylistEvent> {
  // Map of supported extensions with coresonding mime types
  static const List<String> supportedExtensions = [".jpg", ".png", ".jpeg"];

  final Logger log = Logger();
  final PlaylistRepository playlistRepository;

  final PublishSubject<PlaylistLoadingState> _trackSubject = PublishSubject();

  Stream<PlaylistLoadingState> get trackStream => _trackSubject.stream;

  final NotificationBloc notificationBloc;

  PlaylistBloc({this.playlistRepository, this.notificationBloc});

  @override
  void onEvent(event) async {
    if (event is LoadTracks) {
      playlistRepository.getTracksFromPlaylist(event.playlist.id).then((tracks) {
        _trackSubject.add(PlaylistLoadingSuccess(tracks));
      }).catchError((e) {
        _trackSubject
            .add(PlaylistLoadingError(S.current.playlistPage_playlistLoadingError));
      });
    } else if (event is UploadThumbnail) {
      final extension = p.extension(event.image.path);
      final mimeType = mime.mimeFromExtension(extension.replaceAll('.', ''));

      if (!supportedExtensions.contains(extension)) {
        notificationBloc.dispatch(SimpleNotification.error(
            content: S.current.playlistPage_unsupportedExtension));
        return;
      }

      playlistRepository
          .uploadThumbnail(event.playlist.id, event.image, mimeType)
          .then((value) => notificationBloc.dispatch(
              SimpleNotification.info(content: S.current.playlistPage_thumbnailChanged)))
          .catchError((error) => notificationBloc
              .dispatch(SimpleNotification.error(content: "Problem with thumbnail")));
    }
  }

  @override
  void dispose() {
    _trackSubject.close();
  }
}
