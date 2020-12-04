import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/page/library/followed_playlists_bloc.dart';
import 'package:flixage/bloc/page/playlist/load_playlist_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:flixage/ui/widget/bloc_builder.dart';
import 'package:flixage/ui/widget/default_loading_bloc_widget.dart';
import 'package:flixage/ui/widget/item/playlist_item.dart';
import 'package:flixage/ui/widget/list/queryable_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class FollowingTab extends StatefulWidget {
  @override
  _FollowingTabState createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab> {
  GlobalKey<BlocBuilderState<LoadPlaylistBloc, LoadingState<Playlist>>> key;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLoadingBlocWidget<FollowedPlaylistsBloc, List<Playlist>>(
          create: (context) =>
              FollowedPlaylistsBloc(userRepository: Provider.of<UserRepository>(context)),
          onInit: (context, bloc) => bloc.dispatch(Load()),
          builder: (context, _, playlists) {
            return QueryableList<Playlist>(
              items: playlists,
              itemBuilder: (context, playlist) => PlaylistItem(playlist: playlist),
              emptyBuilder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(S.current.libraryPage_tab_followed_notFollowed,
                      style: Theme.of(context).textTheme.headline5),
                  RaisedButton.icon(
                    icon: Icon(Icons.qr_code),
                    label: Text(S.current.libraryPAge_tab_followed_scanQR),
                    onPressed: () => scanner.scan().then(
                      (url) {
                        url = url.substring(url.lastIndexOf("/"));
                        key.currentState.bloc.dispatch(Load(arg: url));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        DefaultLoadingBlocWidget<LoadPlaylistBloc, Playlist>(
          key: key,
          create: (context) => LoadPlaylistBloc(
              playlistRepository: Provider.of<PlaylistRepository>(context)),
          builder: (context, _, playlist) {
            return Container();
          },
        ),
      ],
    );
  }
}
