import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class PlaylistShareContextMenu extends ContextMenu<Playlist> {
  static const String route = "contextMenu/shareplaylist";

  static const double imageSize = 160;

  @override
  List<Widget> createActions(BuildContext context, Playlist item) => [
        ContextMenuItem(
          iconData: Icons.link,
          description: S.current.sharePlaylistContextMenu_copyLink,
          onPressed: () {
            Clipboard.setData(
                ClipboardData(text: "http://www.flixage.com/playlists/" + item.id));
            Provider.of<NotificationBloc>(context, listen: false).dispatch(
                SimpleNotification.info(
                    content: S.current.sharePlaylistContextMenu_linkCopied));
          },
        ),
      ];

  @override
  List<Widget> createHeader(BuildContext context, Playlist item) {
    return [
      SizedBox(height: 120),
      FutureBuilder(
        future: scanner.generateBarCode("http://www.flixage.com/playlists/" + item.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: imageSize,
              height: imageSize,
              color: Colors.white54,
              child: CircularProgressIndicator(),
            );
          }

          return Image.memory(
            snapshot.data,
            width: imageSize,
            height: imageSize,
          );
        },
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.name,
                style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24)),
          ],
        ),
      ),
    ];
  }
}
