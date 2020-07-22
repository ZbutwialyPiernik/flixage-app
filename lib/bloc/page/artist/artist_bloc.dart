import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/artist_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

class ArtistData extends Equatable {
  final List<Track> singles;
  final List<Album> albums;

  ArtistData(this.singles, this.albums);

  @override
  List<Object> get props => [singles, albums];
}

class ArtistBloc extends LoadingBloc<Artist, ArtistData> {
  final ArtistRepository artistRepository;
  final NotificationBloc notificationBloc;

  ArtistBloc({@required this.artistRepository, @required this.notificationBloc});

  @override
  Future<ArtistData> load(Artist artist) async {
    List<Track> singles = await artistRepository.getSingles(artist.id);
    List<Album> albums = await artistRepository.getAlbums(artist.id);

    return ArtistData(singles, albums);
  }
}
