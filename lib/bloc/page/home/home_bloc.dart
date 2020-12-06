import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/album_repository.dart';
import 'package:flixage/repository/artist_repository.dart';
import 'package:flixage/repository/track_repository.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:meta/meta.dart';

class HomeData extends Equatable {
  final List<Track> recentlyListened;
  final List<Track> recentlyAddedTracks;
  final List<Album> recentlyAddedAlbums;
  final List<Artist> recentlyAddedArists;

  HomeData({
    @required this.recentlyListened,
    @required this.recentlyAddedTracks,
    @required this.recentlyAddedAlbums,
    @required this.recentlyAddedArists,
  });

  @override
  List<Object> get props => [recentlyListened, recentlyAddedTracks];
}

class LoadHome extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeBloc extends AbstractLoadingBloc<LoadHome, HomeData> {
  final UserRepository userRepository;
  final TrackRepository trackRepository;
  final ArtistRepository artistRepository;
  final AlbumRepository albumRepository;

  HomeBloc({
    @required this.trackRepository,
    @required this.userRepository,
    @required this.artistRepository,
    @required this.albumRepository,
  });

  @override
  Future<HomeData> load(LoadHome load) async {
    final recentlyListened = (await userRepository.getRecentlyListened()).items;
    final recentlyAddedTracks = (await trackRepository.getRecentlyAdded()).items;
    final recentlyAddedAlbums = (await albumRepository.getRecentlyAdded()).items;
    final recentlyAddedArists = (await artistRepository.getRecentlyAdded()).items;

    return HomeData(
      recentlyListened: recentlyListened,
      recentlyAddedTracks: recentlyAddedTracks,
      recentlyAddedAlbums: recentlyAddedAlbums,
      recentlyAddedArists: recentlyAddedArists,
    );
  }
}
