import 'package:flixage/model/track.dart';
import 'package:flixage/ui/item/context_menu/context_menu.dart';
import 'package:flixage/ui/item/context_menu/track_context_menu.dart';
import 'package:flixage/ui/item/queryable_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackItem extends StatelessWidget {
  final Track track;
  final double height;

  const TrackItem({Key key, this.track, this.height = 64}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryableItem(
      contextMenu: TrackContextMenu(),
      height: height,
      imageUrl: track.thumbnailUrl,
      details: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(track.name, style: TextStyle(fontSize: 18)),
                Text('Utwór • ${track.artists[0].name}',
                    style: TextStyle(color: Colors.white.withOpacity(0.8)))
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => contextMenu.open(context, track),
          ),
        ],
      ),
    );
  }
}
