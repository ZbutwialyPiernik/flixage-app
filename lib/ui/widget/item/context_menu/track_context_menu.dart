import 'package:flixage/bloc/library/library_bloc.dart';
import 'package:flixage/bloc/library/library_event.dart';
import 'package:flixage/ui/pages/routes/album/album_page.dart';
import 'package:flixage/ui/pages/routes/artist/artist_page.dart';
import 'package:flixage/ui/pages/routes/playlist/pick_playlist_page.dart';
import 'package:flixage/ui/widget/named_navigator.dart';
import 'package:flixage/ui/widget/reroute_request.dart';
import 'package:flutter/material.dart';

import 'package:flixage/model/track.dart';

import 'package:flixage/ui/widget/item/context_menu/context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_item.dart';
import 'package:provider/provider.dart';

class TrackContextMenu extends ContextMenu<Track> {
  static const String route = "contextMenu/track";

  @override
  List<ContextMenuItem<Track>> createActions(BuildContext context, Track track) {
    final libraryBloc = Provider.of<LibraryBloc>(context);

    return [
      ContextMenuItem(
          iconData: track.saved ? Icons.favorite : Icons.favorite_border,
          description: "Lubię to",
          onPressed: () {}),
      ContextMenuItem(
          iconData: Icons.add,
          description: "Dodaj do playlisty",
          onPressed: () {
            NamedNavigator.of(context, NamedNavigator.root)
                .popAndPushNamed(PickPlaylistPage.route)
                .then((playlist) {
              if (playlist != null)
                libraryBloc
                    .dispatch(AddTracksToPlaylist(playlist: playlist, tracks: [track]));
            });
          }),
      ContextMenuItem(
          iconData: Icons.queue_music, description: "Dodaj do kolejki", onPressed: () {}),
      if (track.album != null)
        ContextMenuItem(
            iconData: Icons.album,
            description: "Pokaż album",
            onPressed: () => Navigator.of(context)
                .pop(RerouteRequest(route: AlbumPage.route, arguments: track.album))),
      ContextMenuItem(
          iconData: Icons.person,
          description: "Pokaż wykonawcę",
          onPressed: () {
            Navigator.of(context)
                .pop(RerouteRequest(route: ArtistPage.route, arguments: track.artist));
          }),
      ContextMenuItem(iconData: Icons.share, description: "Udostępnij", onPressed: () {})
    ];
  }
}
