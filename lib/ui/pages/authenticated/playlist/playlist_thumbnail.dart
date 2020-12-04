import 'dart:io';

import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/page/playlist/playlist_thumbnail_bloc.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/ui/widget/queryable_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PlaylistThumbnail extends StatefulWidget {
  final Playlist playlist;
  final Size size;

  const PlaylistThumbnail({
    Key key,
    this.playlist,
    this.size,
  }) : super(key: key);

  @override
  _PlaylistThumbnailState createState() => _PlaylistThumbnailState();
}

class _PlaylistThumbnailState extends State<PlaylistThumbnail> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    final bloc = PlaylistThumbnailBloc(
        playlistRepository: Provider.of<PlaylistRepository>(context));

    return StreamBuilder<LoadingState<ThumbnailUploaded>>(
      stream: bloc.state,
      builder: (context, snapshot) {
        return Stack(
          children: [
            defaultBuilder(
              widget.playlist.thumbnailUrl,
              Size(widget.size.width, widget.size.height),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (_) => _setEditMode(!editMode),
              onTapCancel: () => _setEditMode(false),
              child: editMode
                  ? Container(
                      width: widget.size.width,
                      height: widget.size.height,
                      color: Colors.black38,
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          iconSize: 36,
                          onPressed: () {
                            final imagePicker = ImagePicker();
                            imagePicker
                                .getImage(source: ImageSource.gallery)
                                .then((file) {
                              if (file != null) {
                                bloc.dispatch(UploadThumbnail(
                                    image: File.fromUri(Uri.parse(file.path)),
                                    playlist: widget.playlist));
                              }
                            });
                          },
                        ),
                      ),
                    )
                  : SizedBox.fromSize(size: widget.size),
            ),
          ],
        );
      },
    );
  }

  void _setEditMode(bool newMode) {
    setState(() => editMode = newMode);
  }
}
