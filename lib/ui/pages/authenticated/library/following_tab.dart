import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/page/library/followed_playlists_bloc.dart';
import 'package:flixage/bloc/page/playlist/load_playlist_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:flixage/ui/pages/authenticated/playlist/playlist_page.dart';
import 'package:flixage/ui/pages/authenticated/search/search_page.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/bloc_builder.dart';
import 'package:flixage/ui/widget/default_loading_bloc_widget.dart';
import 'package:flixage/ui/widget/item/playlist_item.dart';
import 'package:flixage/ui/widget/list/queryable_list.dart';
import 'package:flixage/ui/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class FollowingTab extends StatefulWidget {
  @override
  _FollowingTabState createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab> {
  final GlobalKey<BlocBuilderState<LoadPlaylistBloc, LoadingState<Playlist>>> key =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLoadingBlocBuilder<FollowedPlaylistsBloc, List<Playlist>>(
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
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton.icon(
                        icon: Icon(Icons.search),
                        label: Text(S.current.searchPage_search),
                        shape: StadiumBorder(),
                        color: Theme.of(context).accentColor,
                        onPressed: () =>
                            Navigator.of(context).pushNamed(SearchPage.route),
                      ),
                      SizedBox(width: 8),
                      RaisedButton.icon(
                        icon: Icon(Icons.qr_code),
                        label: Text(S.current.libraryPAge_tab_followed_scanQR),
                        shape: StadiumBorder(),
                        color: Theme.of(context).accentColor,
                        onPressed: () => scanner.scan().then(
                          (url) {
                            if (url != null) {
                              url = url.substring(url.lastIndexOf("/"));
                              key.currentState.bloc.dispatch(Load(arg: url));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        BlocBuilder<LoadPlaylistBloc, LoadingState<Playlist>>(
          key: key,
          create: (context) => LoadPlaylistBloc(
              playlistRepository: Provider.of<PlaylistRepository>(context)),
          listener: (context, _, state) {
            if (state is LoadingSuccess<Playlist>) {
              Navigator.of(context)
                  .pushNamed(PlaylistPage.route, arguments: Arguments(extra: state.item));
            }
          },
          builder: (context, _, state) {
            if (state is LoadingInProgress) {
              return LoadingWidget();
            }

            return Container();
          },
        ),
      ],
    );
  }
}
