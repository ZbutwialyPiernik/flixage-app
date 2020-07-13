import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/ui/widget/item/context_menu/track_context_menu.dart';
import 'package:flixage/ui/widget/item/queryable_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackItem extends StatelessWidget {
  final Track track;
  final Widget prefix;
  final Widget subheader;
  final double height;

  const TrackItem(
      {Key key, @required this.track, this.height = 64, this.prefix, th, this.subheader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AudioPlayerBloc>(context);

    return QueryableItem(
      onTap: () => bloc.dispatch(PlayTrack(track: track)),
      item: track,
      height: height,
      prefix: prefix,
      contextMenuRoute: TrackContextMenu.route,
      details: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(track.name, style: TextStyle(fontSize: 18)),
          subheader ??
              Text('Utwór • ${track.artist.name}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                  ))
        ],
      ),
    );
  }
}
