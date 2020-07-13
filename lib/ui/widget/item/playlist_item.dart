import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/widget/item/context_menu/playlist_context_menu.dart';
import 'package:flixage/ui/widget/item/queryable_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;
  final double height;
  final Function onTap;

  const PlaylistItem({
    Key key,
    @required this.playlist,
    @required this.onTap,
    this.height = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryableItem(
      height: 80,
      item: playlist,
      contextMenuRoute: PlaylistContextMenu.route,
      onTap: onTap,
      details: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(playlist.name, style: Theme.of(context).textTheme.subtitle1),
          Text("Utworzona przez ${playlist.owner.name}")
        ],
      ),
    );
  }
}