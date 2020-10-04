import 'package:dio/dio.dart';
import 'package:flixage/bloc/page/album/album_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/repository/album_repository.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/item/context_menu/album_context_menu.dart';
import 'package:flixage/ui/widget/item/track_item.dart';
import 'package:flixage/ui/widget/queryable_app_bar.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatelessWidget {
  static const route = "album";

  @override
  Widget build(BuildContext context) {
    final Album album = (ModalRoute.of(context).settings.arguments as Arguments).extra;

    final notificationBloc = Provider.of<NotificationBloc>(context);
    final dio = Provider.of<Dio>(context);
    final artistBloc = AlbumBloc(
      notificationBloc: notificationBloc,
      albumRepository: AlbumRepository(dio),
    );

    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return StatefulWrapper(
      onInit: () => artistBloc.dispatch(album),
      onDispose: () => artistBloc.dispose(),
      child: StreamBuilder<AlbumData>(
        stream: artistBloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          final tracks = snapshot.data.tracks;

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                QueryableAppBar(
                  queryable: album,
                  secondaryText: S.current.albumPage_by(album.artist.name),
                  contextMenuRoute: AlbumContextMenu.route,
                  showRandomButton: true,
                  onRandomButtonTap: () => audioPlayerBloc
                      .dispatch(PlayTracks(playMode: PlayMode.random, tracks: tracks)),
                ),
              ];
            },
            body: SingleChildScrollView(
              controller: PrimaryScrollController.of(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 48),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 16, bottom: 16, top: 16),
                    itemBuilder: (_, index) => TrackItem(
                      track: tracks[index],
                      prefix: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text((index + 1).toString()),
                      ),
                      secondary: Text(tracks[index].streamCount.toString()),
                    ),
                    separatorBuilder: (_, index) => SizedBox(height: 8),
                    itemCount: tracks.length,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
