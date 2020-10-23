import 'package:flixage/model/queryable.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class PlaylistShareContextMenu extends ContextMenu {
  static const String route = "contextMenu/shareplaylist";

  static const double imageSize = 192;

  @override
  List<ContextMenuItem<Queryable>> createActions(BuildContext context, Queryable item) =>
      [];

  @override
  List<Widget> createHeader(BuildContext context, Queryable item) {
    return [
      SizedBox(height: 120),
      FutureBuilder(
        future: scanner.generateBarCode('https://github.com/leyan95/qrcode_scanner'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: imageSize,
              height: imageSize,
              color: Colors.white54,
            );
          }

          return Image.memory(
            snapshot.data,
            width: imageSize,
            height: imageSize,
          );
        },
      )
    ];
  }
}
