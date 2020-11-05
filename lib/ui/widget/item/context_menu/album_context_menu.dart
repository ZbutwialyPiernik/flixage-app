import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/ui/pages/authenticated/artist/artist_page.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_item.dart';
import 'package:flixage/ui/widget/item/context_menu/queryable_context_menu.dart';
import 'package:flutter/material.dart';

class AlbumContextMenu extends QueryableContextMenu<Album> {
  static const String route = "contextMenu/album";

  @override
  List<Widget> createActions(BuildContext context, Album item) {
    return [
      ContextMenuItem(
        iconData: Icons.person,
        description: S.current.trackContextMenu_showArtist,
        onPressed: () => Navigator.of(context)
            .popAndPushNamed(ArtistPage.route, arguments: Arguments(extra: item.artist)),
      ),
    ];
  }
}
