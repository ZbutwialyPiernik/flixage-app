import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/library_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/bloc/notification/simple_notification.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:rxdart/rxdart.dart';

abstract class PlaylistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTracks extends PlaylistEvent {
  final String playlistId;

  LoadTracks(this.playlistId);

  @override
  List<Object> get props => [playlistId];
}

class CreatePlaylist extends PlaylistEvent {
  final String name;

  CreatePlaylist({this.name});

  @override
  List<Object> get props => [name];
}

class DeletePlaylist extends PlaylistEvent {
  final Playlist playlist;

  DeletePlaylist({this.playlist});

  @override
  List<Object> get props => [playlist];
}

class UpdatePlaylist extends PlaylistEvent {
  final Playlist playlist;

  UpdatePlaylist({this.playlist});

  @override
  List<Object> get props => [playlist];
}

class AddTrackToPlaylist extends PlaylistEvent {
  final Playlist playlist;
  final Track track;

  AddTrackToPlaylist({this.playlist, this.track});
}

class RemoveTrackFromPlaylist extends LibraryEvent {
  final Playlist playlist;
  final Track track;

  RemoveTrackFromPlaylist({this.playlist, this.track});
}

class FetchPlaylistTracks extends PlaylistEvent {
  final String playlistId;

  FetchPlaylistTracks(this.playlistId);

  @override
  List<Object> get props => [];
}

abstract class TrackLoadingState extends Equatable {
  TrackLoadingState();

  @override
  List<Object> get props => [];
}

class TrackLoadingSuccess extends TrackLoadingState {
  final List<Track> tracks;

  TrackLoadingSuccess(this.tracks);
}

class TrackLoadingError extends TrackLoadingState {
  final String error;

  TrackLoadingError(this.error);

  @override
  List<Object> get props => [error];
}

class PlaylistBloc extends Bloc<PlaylistEvent> {
  final PlaylistRepository playlistRepository;

  final PublishSubject<TrackLoadingState> _trackSubject = PublishSubject();

  Stream<TrackLoadingState> get trackStream => _trackSubject.stream;

  final NotificationBloc notificationBloc;
  final LibraryBloc libraryBloc;

  PlaylistBloc({this.playlistRepository, this.notificationBloc, this.libraryBloc});

  @override
  void onEvent(event) async {
    if (event is LoadTracks) {
      playlistRepository.getTracksFromPlaylist(event.playlistId).then((tracks) {
        _trackSubject.add(TrackLoadingSuccess(tracks));
      }).catchError((e) {
        _trackSubject.add(TrackLoadingError(e));
      });
    } else if (event is CreatePlaylist) {
      playlistRepository.createPlaylist({'name': event.name}).then((playlist) {
        libraryBloc.dispatch(PlaylistCreated(playlist));
      }).catchError((e) {
        notificationBloc.dispatch(DisplayNotification(
            SimpleNotification(content: "Error during creation of playlist")));
      });
    } else if (event is UpdatePlaylist) {
      playlistRepository
          .updatePlaylist(event.playlist.id, event.playlist)
          .then((playlist) {
        libraryBloc.dispatch(PlaylistUpdated(playlist));
      }).catchError((e) {
        notificationBloc.dispatch(DisplayNotification(
            SimpleNotification(content: "Error during update of playlist")));
      });
    } else if (event is DeletePlaylist) {
      playlistRepository.deletePlaylist(event.playlist.id).then((playlist) {
        libraryBloc.dispatch(PlaylistDeleted(event.playlist));
      }).catchError((e) {
        notificationBloc.dispatch(DisplayNotification(
            SimpleNotification(content: "Error during deletion of playlist")));
      });
    }
  }

  @override
  void dispose() {
    _trackSubject.close();
  }
}
