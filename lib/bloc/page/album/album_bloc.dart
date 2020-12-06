import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/album_repository.dart';
import 'package:meta/meta.dart';

class AlbumData extends Equatable {
  final List<Track> tracks;

  AlbumData({this.tracks});

  @override
  List<Object> get props => [tracks];
}

class AlbumBloc extends AbstractLoadingBloc<Album, AlbumData> {
  final AlbumRepository albumRepository;
  final NotificationBloc notificationBloc;

  AlbumBloc({@required this.albumRepository, @required this.notificationBloc});

  @override
  Future<AlbumData> load(Album album) async {
    final tracks = await albumRepository.getTracksById(album.id);

    return AlbumData(tracks: tracks);
  }
}
