import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/bloc/playlist_bloc.dart';
import 'package:flixage/util/stateful_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePlaylistPage extends StatelessWidget {
  static const route = '/createPlaylist';

  final _nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GlobalBloc>(context).playlistBloc;

    return StatefulWrapper(
      onDispose: () => _nameEditingController.dispose(),
      child: Material(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nameEditingController,
                decoration: InputDecoration(hintText: "Enter name"),
              ),
              IconButton(
                icon: Icon(Icons.add_circle, size: 32),
                onPressed: () => bloc.dispatch(
                  CreatePlaylist(name: _nameEditingController.value.text),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
