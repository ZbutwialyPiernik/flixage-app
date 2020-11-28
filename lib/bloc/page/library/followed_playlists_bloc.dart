import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:meta/meta.dart';

class FollowedPlaylistsBloc extends LoadingBloc<void, List<Playlist>> {
  final UserRepository userRepository;

  FollowedPlaylistsBloc({@required this.userRepository});

  @override
  Future<List<Playlist>> load(void arg) => userRepository.getFollowedPlaylist();
}
