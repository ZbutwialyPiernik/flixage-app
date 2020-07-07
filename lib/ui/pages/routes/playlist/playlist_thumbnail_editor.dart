import 'package:flixage/bloc/playlist/playlist_bloc.dart';
import 'package:flixage/bloc/playlist/playlist_event.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// This is custom overlay over playlist thumbnail, if user will click on image
/// it will toggle into edit mode and user will be able to change playlist image
class PlaylistThumbnailEditor extends StatefulWidget {
  final Playlist playlist;
  final PlaylistBloc playlistBloc;
  final double width;
  final double height;

  const PlaylistThumbnailEditor(
      {Key key,
      @required this.playlist,
      @required this.playlistBloc,
      @required this.width,
      @required this.height})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PlaylistThumbnailEditorState();
}

class PlaylistThumbnailEditorState extends State<PlaylistThumbnailEditor> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => _setEditMode(!editMode),
      onTapCancel: () => _setEditMode(false),
      onTap: () => {
        if (editMode) {_setEditMode(false)}
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: editMode ? Colors.black38 : Colors.transparent,
        child: editMode
            ? Center(
                child: IconButton(
                  icon: Icon(Icons.edit),
                  iconSize: 36,
                  onPressed: () {
                    ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
                      if (file != null) {
                        widget.playlistBloc.dispatch(
                          UploadThumbnail(image: file, playlist: widget.playlist),
                        );
                      }
                    });
                  },
                ),
              )
            : Container(),
      ),
    );
  }

  void _setEditMode(bool newMode) {
    setState(() => editMode = newMode);
  }
}
