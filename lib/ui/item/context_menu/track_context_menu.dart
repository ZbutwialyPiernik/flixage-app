import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/bloc/playlist_bloc.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/ui/item/context_menu/context_menu.dart';
import 'package:flixage/ui/item/context_menu/context_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackContextMenu extends ContextMenu<Track> {
  @override
  List<ContextMenuItem<Track>> createActions(BuildContext context, Track item) {
    return [
      ContextMenuItem(
          iconData: Icons.favorite, description: "Lubię to", onPressed: () {}),
      ContextMenuItem(
          iconData: Icons.favorite, description: "Dodaj do playlisty", onPressed: () {}),
      ContextMenuItem(
          iconData: Icons.favorite, description: "Dodaj do kolejki", onPressed: () {}),
      ContextMenuItem(
          iconData: Icons.favorite, description: "Pokaż album", onPressed: () {}),
      ContextMenuItem(
          iconData: Icons.favorite, description: "Pokaż wykonawcę", onPressed: () {}),
      ContextMenuItem(
          iconData: Icons.favorite, description: "Udostępnij", onPressed: () {})
    ];
  }
}
