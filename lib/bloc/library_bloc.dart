import 'package:equatable/equatable.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

abstract class LibraryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaylistCreated extends LibraryEvent {
  final Playlist playlist;

  PlaylistCreated(this.playlist);
}

class PlaylistDeleted extends LibraryEvent {
  final Playlist playlist;

  PlaylistDeleted(this.playlist);
}

class PlaylistUpdated extends LibraryEvent {
  final Playlist playlist;

  PlaylistUpdated(this.playlist);
}

class FetchLibrary extends LibraryEvent {}

class LibraryBloc extends Bloc<LibraryEvent> {
  static final log = Logger();

  final BehaviorSubject<List<Playlist>> _playlistsSubject = BehaviorSubject();

  final PlaylistRepository playlistRepository;

  Stream<List<Playlist>> get playlists => _playlistsSubject.stream;

  LibraryBloc(this.playlistRepository);

  @override
  void onEvent(LibraryEvent event) async {
    if (event is FetchLibrary) {
      playlistRepository.getCurrentUserPlaylists().then((playlists) {
        _playlistsSubject.add(playlists);
      });
    } else if (event is PlaylistCreated) {
      _playlistsSubject.add(_getPlaylists..add(event.playlist));
    } else if (event is PlaylistDeleted) {
      _playlistsSubject.add(_getPlaylists..remove(event.playlist));
    } else if (event is PlaylistUpdated) {
      _playlistsSubject.add(_getPlaylists
        ..removeWhere((playlist) => playlist.id == event.playlist.id)
        ..add(event.playlist));
    }
  }

  @override
  void dispose() {
    _playlistsSubject.close();
  }

  List<Playlist> get _getPlaylists =>
      _playlistsSubject.hasValue ? _playlistsSubject.value : List();
}
