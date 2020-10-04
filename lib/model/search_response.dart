import 'package:equatable/equatable.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/model/page_response.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/model/user.dart';

class SearchResponse extends Equatable {
  final PageResponse<Track> tracks;
  final PageResponse<Album> albums;
  final PageResponse<Artist> artists;
  final PageResponse<User> users;
  final PageResponse<Playlist> playlists;

  SearchResponse({this.tracks, this.albums, this.artists, this.users, this.playlists});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    var tracks = json['tracks'] != null
        ? PageResponse.fromJson(json['tracks'], Track.fromJson)
        : null;
    var albums = json['albums'] != null
        ? PageResponse.fromJson(json['albums'], Album.fromJson)
        : null;
    var artists = json['artists'] != null
        ? PageResponse.fromJson(json['artists'], Artist.fromJson)
        : null;
    var users = json['users'] != null
        ? PageResponse.fromJson(json['users'], User.fromJson)
        : null;
    var playlists = json['playlists'] != null
        ? PageResponse.fromJson(json['playlists'], Playlist.fromJson)
        : null;

    return SearchResponse(
        tracks: tracks,
        albums: albums,
        artists: artists,
        users: users,
        playlists: playlists);
  }

  bool get isEmpty =>
      _nullOrEmpty(tracks?.items) &&
      _nullOrEmpty(albums?.items) &&
      _nullOrEmpty(artists?.items) &&
      _nullOrEmpty(users?.items) &&
      _nullOrEmpty(playlists?.items);

  bool _nullOrEmpty(List list) => list == null || list.isEmpty;

  @override
  List<Object> get props => [tracks, albums, artists, users, playlists];
}
