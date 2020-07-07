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

  final PublishSubject<ArtistData> _loadingSubject = PublishSubject();

  ArtistBloc({@required this.artistRepository, @required this.notificationBloc});

  @override
  void onEvent(artist) async {
    List<Track> singles = await artistRepository.getSingles(artist.id);
    List<Album> albums = await artistRepository.getAlbums(artist.id);

    _loadingSubject.add(ArtistData(singles, albums));
  }

  @override
  void dispose() {
    _loadingSubject.close();
  }

  @override
  Stream<ArtistData> get stream => _loadingSubject.stream;
}
