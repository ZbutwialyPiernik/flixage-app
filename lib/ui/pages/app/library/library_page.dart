import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/bloc/library_bloc.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/item/playlist_item.dart';
import 'package:flixage/ui/pages/playlist/create_playlist_page.dart';
import 'package:flixage/util/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GlobalBloc>(context).libraryBloc;

    return StatefulWrapper(
      onInit: () => bloc.dispatch(FetchLibrary()),
      child: Container(
        color: Theme.of(context).backgroundColor,
        margin: EdgeInsets.only(left: 8, top: 32, right: 8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Muzyka",
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(CreatePlaylistPage.route)),
              ],
            ),
            //Row(children: <Widget>[ RaisedButton(child: Text(""))]),
            StreamBuilder<List<Playlist>>(
              stream: bloc.playlists,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final playlists = snapshot.data;

                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      Divider(height: 8, color: Colors.transparent),
                  itemCount: playlists.length,
                  itemBuilder: (context, index) =>
                      PlaylistItem(playlist: playlists.elementAt(index)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
