import 'package:dio/dio.dart';
import 'package:flixage/bloc/page/artist/artist_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_bloc.dart';
import 'package:flixage/bloc/audio_player/audio_player_event.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/artist_repository.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/default_loading_bloc_widget.dart';
import 'package:flixage/ui/widget/queryable_app_bar.dart';
import 'package:flixage/ui/widget/item/album_item.dart';
import 'package:flixage/ui/widget/item/context_menu/artist_context_menu.dart';
import 'package:flixage/ui/widget/item/track_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtistPage extends StatefulWidget {
  static const route = '/artist';

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    final Artist artist = (ModalRoute.of(context).settings.arguments as Arguments).extra;

    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return DefaultLoadingBlocWidget<ArtistBloc, ArtistData>(
      create: (context) => ArtistBloc(
        notificationBloc: Provider.of<NotificationBloc>(context),
        artistRepository: ArtistRepository(Provider.of<Dio>(context)),
      ),
      onInit: (context, bloc) => bloc.dispatch(artist),
      builder: (context, _, data) {
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              QueryableAppBar(
                queryable: artist,
                secondaryText:
                    S.current.albumPage_monthlyListeners(artist.monthlyListeners),
                contextMenuRoute: ArtistContextMenu.route,
                showRandomButton: true,
                onRandomButtonTap: () => audioPlayerBloc.dispatch(
                    PlayTracks(playMode: PlayMode.random, tracks: data.singles)),
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
                Text(
                  S.current.artistPage_popular,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 18),
                ),
                ..._buildSingles(data.singles),
                Text(
                  S.current.artistPage_singles,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 18),
                ),
                ..._buildSingles(data.singles),
                Text(
                  S.current.artistPage_albums,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 18),
                ),
                ..._buildAlbums(context, data.albums),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSingles(List<Track> singles) {
    singles.sort((s1, s2) => s2.streamCount.compareTo(s1.streamCount));

    return [
      ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 16, bottom: 16, top: 16),
          itemBuilder: (_, index) => TrackItem(
                track: singles[index],
                prefix: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text((index + 1).toString()),
                ),
                secondary: Text(singles[index].streamCount.toString()),
              ),
          separatorBuilder: (_, index) => SizedBox(height: 8),
          itemCount: singles.length >= 5 ? 5 : singles.length),
      if (singles.length > 5)
        RaisedButton(
          child: Text(S.current.artistPage_showAll),
          onPressed: () {},
        ),
    ];
  }

  List<Widget> _buildAlbums(BuildContext context, List<Album> albums) {
    return [
      ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 16, bottom: 16, top: 16),
          itemBuilder: (_, index) => AlbumItem(
                height: 96,
                album: albums[index],
              ),
          separatorBuilder: (_, index) => SizedBox(height: 8),
          itemCount: albums.length >= 5 ? 5 : albums.length),
      if (albums.length > 5)
        RaisedButton(
          child: Text(S.current.artistPage_showAll),
          onPressed: () {},
        ),
    ];
  }
}
