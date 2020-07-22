import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/bloc/page/library/library_event.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/ui/pages/authenticated/album/album_page.dart';
import 'package:flixage/ui/pages/authenticated/artist/artist_page.dart';
import 'package:flixage/ui/pages/authenticated/arguments.dart';
import 'package:flixage/ui/pages/authenticated/playlist/pick_playlist_page.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_item.dart';
import 'package:flutter/material.dart';

import 'package:flixage/model/track.dart';

import 'package:provider/provider.dart';

class TrackContextMenu extends ContextMenu<Track> {
  static const String route = "contextMenu/track";

  @override
  List<ContextMenuItem<Track>> createActions(BuildContext context, Track track) {
    final libraryBloc = Provider.of<LibraryBloc>(context);

    return [
      ContextMenuItem(
          iconData: Icons.add,
          description: S.current.trackContextMenu_addToPlaylist,
          onPressed: () {
            Navigator.of(context)
                .popAndPushNamed(PickPlaylistPage.route,
                    arguments: Arguments(showBottomAppBar: false))
                .then((playlist) {
              if (playlist != null)
                libraryBloc
                    .dispatch(AddTracksToPlaylist(playlist: playlist, tracks: [track]));
            });
          }),
      if (track.album != null)
        ContextMenuItem(
          iconData: Icons.album,
          description: S.current.trackContextMenu_showAlbum,
          onPressed: () => Navigator.of(context)
              .popAndPushNamed(AlbumPage.route, arguments: Arguments(extra: track.album)),
        ),
      ContextMenuItem(
        iconData: Icons.person,
        description: S.current.trackContextMenu_showArtist,
        onPressed: () => Navigator.of(context)
            .popAndPushNamed(ArtistPage.route, arguments: Arguments(extra: track.artist)),
      ),
      ContextMenuItem(
          iconData: Icons.share,
          description: S.current.playlistContextMenu_sharePlaylist,
          onPressed: () {})
    ];
  }
}
