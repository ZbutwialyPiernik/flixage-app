import 'package:flixage/bloc/library/library_bloc.dart';
import 'package:flixage/bloc/library/library_event.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/pages/routes/playlist/create_playlist_page.dart';
import 'package:flixage/ui/pages/routes/playlist/playlist_page.dart';
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
        margin: EdgeInsets.only(left: 8, top: 32, right: 8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Muzyka",
                  style: Theme.of(context).textTheme.headline5,
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
                  return Container();
                }

                final playlists = snapshot.data;
                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: playlists.length,
                  itemBuilder: (context, index) => PlaylistItem(
                      playlist: playlists[index],
                      onTap: () => Navigator.of(context)
                          .pushNamed(PlaylistPage.route, arguments: playlists[index])),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
