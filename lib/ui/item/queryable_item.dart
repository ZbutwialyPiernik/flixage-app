import 'package:flixage/model/queryable.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'context_menu/context_menu.dart';

class QueryableItem<T extends Queryable> extends StatelessWidget {
  final Function onTap;
  final Function onLongPress;
  final String imageUrl;
  final Widget details;
  final Color backgroundColor;
  final double width;
  final double height;
  final ContextMenu<T> contextMenu;
  final T item;

  const QueryableItem(
      {Key key,
      @required this.onTap,
      @required this.onLongPress,
      @required this.imageUrl,
      @required this.details,
      @required this.item,
      this.width = double.infinity,
      this.height = 64,
      this.backgroundColor = Colors.transparent,
      this.contextMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: double.infinity,
        height: height,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                // Image is a rectangle she we will use height as width
                CachedNetworkImage(imageUrl: imageUrl, width: height, height: height),
                Expanded(child: details)
              ],
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => contextMenu.open(context, item),
            ),
          ],
        ),
      ),
    );
  }
}
