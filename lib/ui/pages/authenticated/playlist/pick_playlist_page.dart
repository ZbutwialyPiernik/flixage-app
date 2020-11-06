import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/bloc/page/library/library_event.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/widget/bloc_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickPlaylistPage extends StatelessWidget {
  static const route = '/pickPlaylist';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, List<Playlist>>(
      create: (context) => Provider.of<LibraryBloc>(context),
      onInit: (context, bloc) => bloc.dispatch(LoadLibrary()),
      builder: (context, _, snapshot) => Column(
        children: <Widget>[
          AppBar(
            centerTitle: true,
            title: Text(S.current.pickPlaylistPage_addToPlaylist,
                style: Theme.of(context).textTheme.headline6),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          /*
          Expanded(
            child: PlaylistList(
              onItemTap: (playlist) => Navigator.of(context).pop(playlist),
            ),
          ),*/
        ],
      ),
    );
  }
}
