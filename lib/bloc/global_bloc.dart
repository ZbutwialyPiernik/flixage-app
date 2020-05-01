import 'package:flixage/bloc/audio_player_bloc.dart';
import 'package:flixage/bloc/authentication_bloc.dart';
import 'package:flixage/bloc/library_bloc.dart';
import 'package:flixage/bloc/login_bloc.dart';
import 'package:flixage/bloc/playlist_bloc.dart';
import 'package:flixage/bloc/search_bloc.dart';

class GlobalBloc {
  final AudioPlayerBloc audioPlayerBloc;
  final SearchBloc searchBloc;
  final AuthenticationBloc authenticationBloc;
  final LibraryBloc libraryBloc;
  final PlaylistBloc playlistBloc;

  GlobalBloc(
      {this.audioPlayerBloc,
      this.searchBloc,
      this.authenticationBloc,
      this.libraryBloc,
      this.playlistBloc});

  void dispose() {
    audioPlayerBloc.dispose();
    searchBloc.dispose();
    authenticationBloc.dispose();
    libraryBloc.dispose();
  }
}
