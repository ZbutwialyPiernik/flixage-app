import 'package:flixage/model/queryable.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_button.dart';
import 'package:flutter/material.dart';

class QueryableItem<T extends Queryable> extends StatelessWidget {
  final Function onTap;
  final Widget primary;
  final Widget secondary;
  final Widget leading;
  final Color backgroundColor;
  final String contextMenuRoute;
  final double height;
  final bool roundedImage;
  final T item;

  const QueryableItem({
    Key key,
    @required this.onTap,
    @required this.secondary,
    @required this.item,
    this.primary,
    this.leading,
    this.roundedImage = false,
    this.height = 56,
    this.contextMenuRoute,
    this.backgroundColor = Colors.transparent,
  })  : assert(onTap != null),
        assert(secondary != null),
        assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      onLongPress: () => {
        if (contextMenuRoute != null)
          Navigator.of(context)
              .pushNamed(contextMenuRoute, arguments: Arguments(extra: item))
      },
      child: Container(
        height: height,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                leading ??
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
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        primary ??
                            Text(item.name, style: Theme.of(context).textTheme.subtitle1),
                        secondary,
                      ],
                    ),
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
