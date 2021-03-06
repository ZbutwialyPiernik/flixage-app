import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/bloc/page/library/library_event.dart';
import 'package:flixage/bloc/page/library/top_artists_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:flixage/ui/pages/authenticated/library/following_tab.dart';
import 'package:flixage/ui/pages/authenticated/playlist/create_playlist_page.dart';
import 'package:flixage/ui/pages/authenticated/playlist/playlist_page.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/cached_tab.dart';
import 'package:flixage/ui/widget/default_loading_bloc_widget.dart';
import 'package:flixage/ui/widget/item/artist_item.dart';
import 'package:flixage/ui/widget/item/playlist_item.dart';
import 'package:flixage/ui/widget/list/queryable_list.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  static const String route = "library";

  final Logger logger = Logger();

  @override
  State<StatefulWidget> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelStyle: Theme.of(context).textTheme.headline6,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Colors.white.withOpacity(1),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: S.current.libraryPage_tab_playlists_title),
              Tab(text: S.current.libraryPage_tab_artists_title),
              Tab(text: S.current.libraryPage_tab_followed_title)
            ],
          ),
          Expanded(
            child: TabBarView(
              children: _buildTabs(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabs(BuildContext context) {
    return [
      CachedTab(
        child: DefaultLoadingBlocBuilder<LibraryBloc, List<Playlist>>(
          onInit: (context, bloc) => bloc.dispatch(LoadLibrary()),
          builder: (context, _, state) {
            return QueryableList<Playlist>(
              items: state,
              leadingTiles: [_createPlaylistItem(context)],
              itemBuilder: (context, playlist) => PlaylistItem(
                playlist: playlist,
                onTap: (playlist) => Navigator.of(context).pushNamed(
                  PlaylistPage.route,
                  arguments: Arguments(extra: playlist),
                ),
              ),
              emptyBuilder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.current.libraryPage_tab_playlists_noPlaylists,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                    onPressed: () => Navigator.of(context).pushNamed(
                        CreatePlaylistPage.route,
                        arguments: Arguments(showBottomAppBar: false)),
                    child: Text(S.current.libraryPage_tab_playlists_createPlaylist),
                  )
                ],
              ),
            );
          },
        ),
      ),
      CachedTab(
          child: DefaultLoadingBlocBuilder<TopArtistsBloc, List<Artist>>(
        create: (context) =>
            TopArtistsBloc(userRepository: Provider.of<UserRepository>(context)),
        onInit: (context, bloc) => bloc.dispatch(Load()),
        builder: (context, _, artits) {
          return QueryableList<Artist>(
            items: artits,
            itemBuilder: (context, artist) => ArtistItem(artist: artist),
            emptyBuilder: (context) => Center(
              child: Text(S.current.libraryPage_tab_artists_notPlayed,
                  style: Theme.of(context).textTheme.headline5),
            ),
          );
        },
      )),
      CachedTab(child: FollowingTab()),
    ];
  }

  Widget _createPlaylistItem(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(CreatePlaylistPage.route,
          arguments: Arguments(showBottomAppBar: false)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 80,
            width: 80,
            color: Colors.white12,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                S.current.libraryPage_tab_playlists_createPlaylist,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
