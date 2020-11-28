import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:meta/meta.dart';

class FollowPlaylistBloc extends LoadingBloc<String, void> {
  static const int codeLength = 6;

  final PlaylistRepository playlistRepository;

  FollowPlaylistBloc({@required this.playlistRepository});

  @override
  Future<void> load(String id) async {
    try {
      await playlistRepository.followPlaylist(id);
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.RESPONSE) {
        if (e.response.statusCode == HttpStatus.notFound) {
          return Future.error("Invalid share code");
        } else if (e.response.statusCode == HttpStatus.badRequest) {
          return Future.error("You cannot follow your own playlist");
        } else if (e.response.statusCode == HttpStatus.conflict) {
          return Future.error("You're already following this playlist");
        }
      }

      return Future.error(e);
    }
  }
}
