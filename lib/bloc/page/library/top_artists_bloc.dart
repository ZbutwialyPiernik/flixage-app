import 'package:equatable/equatable.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:meta/meta.dart';

import '../../loading_bloc.dart';

class LoadArtists extends Equatable {
  @override
  List<Object> get props => [];
}

class TopArtistsBloc extends LoadingBloc<LoadArtists, List<Artist>> {
  final UserRepository userRepository;

  TopArtistsBloc({@required this.userRepository});

  @override
  Future<List<Artist>> load(LoadArtists event) async {
    final page = await userRepository.getMostListened();

    return page.items;
  }
}
