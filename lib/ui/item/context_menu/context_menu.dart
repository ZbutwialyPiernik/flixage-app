import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixage/model/queryable.dart';
import 'package:flixage/ui/item/context_menu/context_menu_item.dart';
import 'package:flutter/material.dart';

abstract class ContextMenu<T extends Queryable> {
  OverlayEntry _entry;

  void open(BuildContext context, T item) {
    _entry = OverlayEntry(
      builder: (context) => _build(context, item),
    );

    Overlay.of(context).insert(_entry);
  }

  @protected
  List<ContextMenuItem<T>> createActions(BuildContext context, T item);

  Widget _build(BuildContext context, T item) {
    return WillPopScope(
      onWillPop: () async {
        close();
        return true;
      },
      child: Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () => close(),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1)
                  ],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: <Widget>[
                  Divider(height: 100),
                  CachedNetworkImage(
                      imageUrl: item.thumbnailUrl, width: 128, height: 128),
                  Text(item.name),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: createActions(context, item),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void close() {
    _entry?.remove();
    _entry = null;
  }
}
