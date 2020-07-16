import 'package:flixage/bloc/library/library_bloc.dart';
import 'package:flixage/bloc/library/library_event.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/pages/authenticated/arguments.dart';
import 'package:flixage/ui/pages/authenticated/playlist/create_playlist_page.dart';
import 'package:flixage/ui/pages/authenticated/playlist/playlist_page.dart';
import 'package:flixage/ui/widget/item/playlist_item.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatelessWidget {
  static const String route = "library";

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LibraryBloc>(context);

    return StatefulWrapper(
      onInit: () => bloc.dispatch(FetchLibrary()),
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(S.current.libraryPage_title,
                style: Theme.of(context).textTheme.headline6),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.add_circle),
                onPressed: () => Navigator.of(context).pushNamed(CreatePlaylistPage.route,
                    arguments: Arguments(showBottomAppBar: false)),
              )
            ],
          ),
          StreamBuilder<List<Playlist>>(
            stream: bloc.playlists,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              if (snapshot.data.isEmpty) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text(S.current.libraryPage_noPlaylists)],
                  ),
                );
              }

              final playlists = snapshot.data;
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: playlists.length,
                  itemBuilder: (context, index) => PlaylistItem(
                    playlist: playlists[index],
                    onTap: () => Navigator.of(context).pushNamed(PlaylistPage.route,
                        arguments: Arguments(extra: playlists[index])),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
