import 'package:flixage/bloc/authentication/authentication_bloc.dart';
import 'package:flixage/bloc/follow_playlist_bloc.dart';
import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/bloc/page/library/library_event.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/pages/authenticated/user/user_page.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/bloc_builder.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_item.dart';
import 'package:flixage/ui/widget/item/context_menu/playlist_share_context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/queryable_context_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistContextMenu extends QueryableContextMenu<Playlist> {
  static const String route = "contextMenu/playlist";

  @override
  List<Widget> createActions(BuildContext context, Playlist playlist) {
    final bloc = Provider.of<LibraryBloc>(context);
    final authenticationBloc = Provider.of<AuthenticationBloc>(context);

    return [
      ContextMenuItem(
        iconData: Icons.clear,
        description: S.current.playlistContextMenu_removePlaylist,
        onPressed: () {
          bloc.dispatch(DeletePlaylist(playlist: playlist));
          Navigator.of(context).pop();
        },
      ),
      if (playlist.isOwner(authenticationBloc.currentUser))
        ContextMenuItem(
          iconData: Icons.edit,
          description: S.current.playlistContextMenu_editPlaylist,
          onPressed: () {},
        ),
      if (playlist.isNotOwner(authenticationBloc.currentUser))
        ContextMenuItem(
          iconData: Icons.person,
          description: S.current.contextMenu_showAuthor,
          onPressed: () => Navigator.of(context).pushNamed(
            UserPage.route,
            arguments: Arguments(extra: playlist.owner),
          ),
        ),
      if (playlist.isNotOwner(authenticationBloc.currentUser))
        BlocBuilder<FollowPlaylistBloc, void>(
          builder: (context, bloc, snapshot) {
            return ContextMenuItem(
              iconData: Icons.favorite,
              description: "Observe",
              onPressed: () => bloc.dispatch(playlist.id),
            );
          },
        ),
      ContextMenuItem(
        iconData: Icons.share,
        description: S.current.playlistContextMenu_sharePlaylist,
        onPressed: () => Navigator.popAndPushNamed(
            context, PlaylistShareContextMenu.route,
            arguments:
                Arguments(showBottomAppBar: false, opaque: false, extra: playlist)),
      )
    ];
  }
}
