import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/item/item_with_thumbnail.dart';
import 'package:flixage/ui/pages/playlist/playlist_page.dart';
import 'package:flutter/cupertino.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;

  const PlaylistItem({Key key, this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemWithThumbnail(
      onTap: () =>
          Navigator.of(context).pushNamed(PlaylistPage.route, arguments: playlist),
      imageUrl: playlist.thumbnailUrl,
      details: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(playlist.name),
            Text("utworzona przez ZbutwialyPiernik")
          ],
        ),
      ),
    );
  }
}
