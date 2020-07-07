import 'package:flixage/model/user.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  static const route = '/user';

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

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
                  CustomImage(
                    imageUrl: user.thumbnailUrl,
                    width: 64,
                    height: 64,
                  )
                ],
              ),
              Text(user.name),
            ],
          ),
        ),
      ),
    );
  }
}
