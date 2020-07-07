import 'package:flixage/bloc/library/library_bloc.dart';
import 'package:flixage/bloc/library/library_event.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistContextMenu extends ContextMenu<Playlist> {
  static const String route = "contextMenu/playlist";

  @override
  List<ContextMenuItem<Playlist>> createActions(BuildContext context, Playlist playlist) {
    final bloc = Provider.of<LibraryBloc>(context);

    return [
      ContextMenuItem(
        iconData: Icons.clear,
        description: "Usuń playlistę",
        onPressed: () {
          bloc.dispatch(DeletePlaylist(playlist: playlist));
          Navigator.of(context).pop();
        },
      ),
      ContextMenuItem(
          iconData: Icons.edit, description: "Edytuj playlistę", onPressed: () {}),
      ContextMenuItem(
          iconData: Icons.edit, description: "Udostępnij playlistę", onPressed: () {})
    ];
  }
}
