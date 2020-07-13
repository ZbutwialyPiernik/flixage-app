import 'package:flixage/bloc/library/library_bloc.dart';
import 'package:flixage/bloc/library/library_event.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/pages/authenticated/page_settings.dart';
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
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text("Playlisty", style: Theme.of(context).textTheme.headline6),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () => Navigator.of(context).pushNamed(
                      CreatePlaylistPage.route,
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
                      children: <Widget>[Text("Nie masz jeszcze żadnej playlisty")],
                    ),
                  );
                }

                final playlists = snapshot.data;
                return Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 8),
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
      ),
    );
  }
}
