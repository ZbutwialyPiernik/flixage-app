import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:meta/meta.dart';

class TopArtistsBloc extends AbstractLoadingBloc<void, List<Artist>> {
  final UserRepository userRepository;

  TopArtistsBloc({@required this.userRepository});

  @override
  Future<List<Artist>> load(void arg) async {
    final page = await userRepository.getMostListened();

    return page.items;
  }
}
