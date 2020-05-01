import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/bloc/playlist_bloc.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/item/context_menu/context_menu.dart';
import 'package:flixage/ui/item/context_menu/context_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistContextMenu extends ContextMenu<Playlist> {
  @override
  List<ContextMenuItem<Playlist>> createActions(BuildContext context, Playlist playlist) {
    final PlaylistBloc bloc = Provider.of<GlobalBloc>(context).playlistBloc;

    return [
      ContextMenuItem(
        iconData: Icons.clear,
        description: "Usuń playlistę",
        onPressed: () {
          bloc.dispatch(DeletePlaylist(playlist: playlist));
          close();
        },
      ),
      ContextMenuItem(
          iconData: Icons.edit, description: "Edytuj playlistę", onPressed: () {})
    ];
  }
}
