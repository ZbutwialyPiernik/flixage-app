import 'package:flixage/model/queryable.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu.dart';
import 'package:flutter/material.dart';

abstract class QueryableContextMenu<T extends Queryable> extends ContextMenu<T> {
  const QueryableContextMenu({
    Key key,
  }) : super(key: key);

  @protected
  List<Widget> createHeader(BuildContext context, T item) {
    return [
      SizedBox(height: 120),
      Column(
        children: <Widget>[
          CustomImage(imageUrl: item.thumbnailUrl, width: 128, height: 128),
          SizedBox(height: 16),
          Text(item.name,
              style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 16)),
          SizedBox(height: 24),
        ],
      )
    ];
  }
}
