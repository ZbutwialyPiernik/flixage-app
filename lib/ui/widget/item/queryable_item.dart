import 'package:flixage/model/queryable.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flixage/ui/widget/named_navigator.dart';

import 'package:flixage/ui/widget/reroute_request.dart';

class QueryableItem<T extends Queryable> extends StatelessWidget {
  final Function onTap;
  final Widget details;
  final Widget prefix;
  final Color backgroundColor;
  final String contextMenuRoute;
  final double height;
  final bool roundedImage;
  final T item;

  const QueryableItem({
    Key key,
    @required this.onTap,
    @required this.details,
    @required this.item,
    this.prefix,
    this.roundedImage = false,
    this.height = 56,
    this.contextMenuRoute,
    this.backgroundColor = Colors.transparent,
  })  : assert(onTap != null),
        assert(details != null),
        assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      onLongPress: () => {
        if (contextMenuRoute != null)
          handleReroute(
              Navigator.of(context),
              NamedNavigator.of(context, NamedNavigator.root)
                  .pushNamed(contextMenuRoute, arguments: item))
      },
      child: Container(
        width: double.infinity,
        height: height,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                prefix ??
                    // By default thumbnail is prefix widget
                    // Image is a rectangle she we will use height as width
                    CustomImage(
                      imageUrl: item.thumbnailUrl,
                      width: height,
                      height: height,
                      rounded: roundedImage,
                    ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: details,
                  ),
                ),
                if (contextMenuRoute != null)
                  ContextMenuButton(
                    route: contextMenuRoute,
                    item: item,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
