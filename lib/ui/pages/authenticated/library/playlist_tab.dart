import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/bloc/page/library/library_event.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/pages/authenticated/playlist/create_playlist_page.dart';
import 'package:flixage/ui/pages/authenticated/playlist/playlist_page.dart';
import 'package:flixage/ui/widget/item/playlist_item.dart';
import 'package:flixage/ui/widget/loading_widget.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LibraryBloc>(context);

    return StatefulWrapper(
      onInit: () => bloc.dispatch(FetchLibrary()),
      child: Column(
        children: <Widget>[
          StreamBuilder<List<Playlist>>(
            stream: bloc.playlists,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LoadingWidget();
              }

              if (snapshot.data.isEmpty) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildCreatePlaylistButton(context),
                      Text(S.current.libraryPage_noPlaylists)
                    ],
                  ),
                );
              }

              final playlists = snapshot.data;

              return Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: playlists.length + 1,
                    itemBuilder: (context, index) =>
                        _buildItem(context, index, playlists)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, List<Playlist> playlists) {
    if (index == 0) {
      return _buildCreatePlaylistButton(context);
    }

    return PlaylistItem(
      playlist: playlists[index - 1],
      onTap: () => Navigator.of(context)
          .pushNamed(PlaylistPage.route, arguments: Arguments(extra: playlists[index])),
    );
  }

  Widget _buildCreatePlaylistButton(BuildContext context) {
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
                "Utwórz playlistę",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}