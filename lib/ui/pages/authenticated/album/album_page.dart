import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/page/album/album_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/repository/album_repository.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/default_loading_bloc_widget.dart';
import 'package:flixage/ui/widget/item/context_menu/album_context_menu.dart';
import 'package:flixage/ui/widget/item/track_item.dart';
import 'package:flixage/ui/widget/queryable_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatelessWidget {
  static const route = "album";

  @override
  Widget build(BuildContext context) {
    final Album album = (ModalRoute.of(context).settings.arguments as Arguments).extra;
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return DefaultLoadingBlocWidget<AlbumBloc, AlbumData>(
      create: (context) => AlbumBloc(
          notificationBloc: Provider.of<NotificationBloc>(context),
          albumRepository: Provider.of<AlbumRepository>(context)),
      onInit: (context, bloc) => bloc.dispatch(Load(arg: album)),
      builder: (context, _, data) {
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              QueryableAppBar(
                queryable: album,
                secondaryText: S.current.albumPage_by(album.artist.name),
                contextMenuRoute: AlbumContextMenu.route,
                showRandomButton: true,
                onRandomButtonTap: () => audioPlayerBloc
                    .dispatch(PlayTracks(playMode: PlayMode.random, tracks: data.tracks)),
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
                    track: data.tracks[index],
                    prefix: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text((index + 1).toString()),
                    ),
                    secondary: Text(data.tracks[index].streamCount.toString()),
                  ),
                  separatorBuilder: (_, index) => SizedBox(height: 8),
                  itemCount: data.tracks.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoadingStatus {}
