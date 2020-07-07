import 'package:flixage/bloc/library/library_bloc.dart';
import 'package:flixage/bloc/library/library_event.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/pages/routes/playlist/create_playlist_page.dart';
import 'package:flixage/ui/widget/item/playlist_item.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickPlaylistPage extends StatelessWidget {
  static const route = '/pickPlaylist';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LibraryBloc>(context);

    return StatefulWrapper(
      onInit: () => bloc.dispatch(FetchLibrary()),
      child: Material(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("NOWA PLAYLISTA"),
                onPressed: () =>
                    Navigator.of(context).pushNamed(CreatePlaylistPage.route),
                shape: StadiumBorder(),
              ),
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
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: playlists.length,
                    itemBuilder: (context, index) => PlaylistItem(
                        onTap: () => Navigator.of(context).pop(playlists[index]),
                        playlist: playlists[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
