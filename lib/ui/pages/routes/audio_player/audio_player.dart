import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/ui/pages/routes/artist/artist_page.dart';
import 'package:flixage/ui/pages/routes/audio_player/audio_player_slider.dart';
import 'package:flixage/ui/pages/routes/audio_player/subcomponent/audio_player_state_button.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/item/context_menu/track_context_menu.dart';
import 'package:flixage/ui/widget/notification_root.dart';
import 'package:flixage/ui/widget/named_navigator.dart';
import 'package:flixage/ui/widget/reroute_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerPage extends StatelessWidget {
  static const String route = "audioPlayer";

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final _bloc = Provider.of<AudioPlayerBloc>(context);

    return NotificationRoot(
      scaffoldKey: scaffoldKey,
      child: Scaffold(
        key: scaffoldKey,
        body: StreamBuilder<Track>(
          stream: _bloc.audio,
          builder: (context, snapshot) {
            final track = snapshot.data;

            if (!snapshot.hasData) {
              return Container();
            }

            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        onPressed: () => Navigator.of(context).pop()),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () => NamedNavigator.of(context, NamedNavigator.root)
                          .pushNamed(TrackContextMenu.route, arguments: track),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 8.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 1))
                    ],
                  ),
                  child: CustomImage(
                    width: double.infinity,
                    imageUrl: track.thumbnailUrl,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                track.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontSize: 22.0),
                              ),
                              InkWell(
                                child: Text(track.artist.name,
                                    style:
                                        TextStyle(color: Colors.white.withOpacity(0.6))),
                                onTap: () => Navigator.pop(
                                  context,
                                  RerouteRequest(
                                      route: ArtistPage.route, arguments: track.artist),
                                ),
                              ),
                            ],
                          ),
                          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
                        ],
                      ),
                      AudioPlayerSlider(track: snapshot.data),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          StreamBuilder<PlayMode>(
                            stream: _bloc.playMode,
                            builder: (context, snapshot) {
                              return IconButton(
                                iconSize: 32,
                                icon: Icon(Icons.shuffle),
                                color: snapshot.data == PlayMode.random
                                    ? Theme.of(context).accentColor
                                    : null,
                                onPressed: () => _bloc.dispatch(new TogglePlayMode()),
                              );
                            },
                          ),
                          IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.skip_previous),
                              onPressed: () => _bloc.dispatch(PlayPreviousEvent())),
                          AudioPlayerStateButton(
                              bloc: _bloc,
                              iconSize: 72,
                              playIcon: Icons.play_circle_filled,
                              pauseIcon: Icons.pause_circle_filled),
                          IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.skip_next),
                              onPressed: () => _bloc.dispatch(PlayNextEvent())),
                          StreamBuilder<LoopMode>(
                            stream: _bloc.loopMode,
                            builder: (context, snapshot) {
                              Icon icon;
                              switch (snapshot.data) {
                                case LoopMode.single:
                                  icon = Icon(Icons.repeat_one,
                                      color: Theme.of(context).accentColor);
                                  break;
                                case LoopMode.playlist:
                                  icon = Icon(Icons.repeat,
                                      color: Theme.of(context).accentColor);
                                  break;
                                case LoopMode.none:
                                  icon = Icon(Icons.repeat);
                                  break;
                              }

                              return IconButton(
                                iconSize: 32,
                                icon: icon,
                                onPressed: () => _bloc.dispatch(
                                  new TogglePlaybackMode(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
