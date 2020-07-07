import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/album_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

class AlbumData extends Equatable {
  final List<Track> tracks;

  AlbumData({this.tracks});

  @override
  List<Object> get props => [tracks];
}

class AlbumBloc extends LoadingBloc<Album, AlbumData> {
  final AlbumRepository albumRepository;

  final NotificationBloc notificationBloc;

  final PublishSubject<AlbumData> _loadingSubject = PublishSubject();

  AlbumBloc({@required this.albumRepository, @required this.notificationBloc});

  @override
  void onEvent(album) async {
    List<Track> tracks = await albumRepository.getTracksById(album.id);

    _loadingSubject.add(AlbumData(tracks: tracks));
  }

  @override
  void dispose() {
    _loadingSubject.close();
  }

  @override
  Stream<AlbumData> get stream => _loadingSubject.stream;
}
