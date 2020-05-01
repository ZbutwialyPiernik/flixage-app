import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/util/stateful_wrapper.dart';
import 'package:flutter/material.dart';

class ArtistPage extends StatelessWidget {
  static const route = '/playlist';

  @override
  Widget build(BuildContext context) {
    final Artist artist = ModalRoute.of(context).settings.arguments;

    //final Artist playlistBloc = PlaylistBloc();
    //final AudioPlayerBloc au`dioPlayerBloc =
    //Provider.of<GlobalBloc>(context).audioPlayerBloc;

    return StatefulWrapper(
      //onInit: () => playlistBloc.dispatch(LoadTracks(playlist.id)),
      //onDispose: () => playlistBloc.dispose(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: artist.thumbnailUrl,
                  )
                ],
              ),
              Row(
                children: <Widget>[Text(artist.name)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
