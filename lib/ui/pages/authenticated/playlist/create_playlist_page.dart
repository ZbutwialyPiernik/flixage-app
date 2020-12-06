import 'package:flixage/bloc/form_bloc.dart';
import 'package:flixage/bloc/page/create_playlist/create_playlist_bloc.dart';
import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePlaylistPage extends StatelessWidget {
  static const route = '/createPlaylist';

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = CreatePlaylistBloc(Provider.of<LibraryBloc>(context));

    return StatefulWrapper(
      onInit: () {
        _nameController.addListener(() {
          bloc.dispatch(TextChanged({
            'name': _nameController.text,
          }));
        });
      },
      onDispose: () => _nameController.dispose(),
      child: StreamBuilder<FormBlocState>(
        stream: bloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state is FormSubmitSuccess) {
            Navigator.of(context).pop();
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(S.current.createPlaylistPage_namePlaylist,
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 16),
                TextField(
                  textAlign: TextAlign.center,
                  controller: _nameController,
                  readOnly: state is FormLoading,
                  decoration: InputDecoration(
                    errorText: (state is FormValidationError)
                        ? state.errors['name'].error
                        : null,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, size: 32),
                  onPressed: () {
                    bloc.dispatch(SubmitForm({
                      'name': _nameController.text,
                    }));
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
