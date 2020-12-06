import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/user.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:meta/meta.dart';

class UserData extends Equatable {
  final List<Playlist> playlists;

  UserData(this.playlists);

  @override
  List<Object> get props => [playlists];
}

class UserBloc extends AbstractLoadingBloc<User, UserData> {
  final PlaylistRepository playlistRepository;

  UserBloc({@required this.playlistRepository});

  @override
  Future<UserData> load(User user) async {
    final playlist = await playlistRepository.getUserPlaylists(user.id);

    return UserData(playlist);
  }
}
