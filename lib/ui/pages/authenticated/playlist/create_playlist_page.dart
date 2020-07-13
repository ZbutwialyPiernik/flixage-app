import 'package:flixage/bloc/library/library_bloc.dart';
import 'package:flixage/bloc/library/library_event.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePlaylistPage extends StatelessWidget {
  static const route = '/createPlaylist';

  final TextEditingController _nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LibraryBloc>(context);

    return StatefulWrapper(
      onInit: () => _nameEditingController,
      onDispose: () => _nameEditingController.dispose(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Nazwij swoją playlistę", style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            TextField(
              textAlign: TextAlign.center,
              controller: _nameEditingController,
            ),
            IconButton(
              icon: Icon(Icons.add_circle, size: 32),
              onPressed: () {
                bloc.dispatch(
                  CreatePlaylist(name: _nameEditingController.value.text),
                );
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
