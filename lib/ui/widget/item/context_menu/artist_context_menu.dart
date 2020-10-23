import 'package:flixage/model/artist.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_item.dart';
import 'package:flixage/ui/widget/item/context_menu/queryable_context_menu.dart';
import 'package:flutter/material.dart';

class ArtistContextMenu extends QueryableContextMenu<Artist> {
  static const String route = "contextMenu/artist";

  @override
  List<ContextMenuItem<Artist>> createActions(BuildContext context, Artist item) {
    return [];
  }
}
