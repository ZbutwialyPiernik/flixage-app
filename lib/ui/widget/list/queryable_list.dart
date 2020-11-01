import 'package:flixage/model/queryable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QueryableList<T extends Queryable> extends StatelessWidget {
  static const EdgeInsets defaultPadding =
      const EdgeInsets.only(left: 16, top: 16, bottom: 16);

  final EdgeInsets padding;
  final List<Widget> leadingTiles;
  final List<T> items;
  final double itemSpacing;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget Function(BuildContext context) emptyBuilder;

  const QueryableList({
    Key key,
    @required this.items,
    @required this.itemBuilder,
    @required this.emptyBuilder,
    this.itemSpacing = 8,
    this.padding = defaultPadding,
    this.leadingTiles = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (items.isEmpty) {
      child = SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (leadingTiles.isNotEmpty)
              ListView.separated(
                padding: padding,
                separatorBuilder: (context, index) => SizedBox(height: itemSpacing),
                itemCount: leadingTiles.length,
                itemBuilder: (context, index) => leadingTiles[index],
              ),
            emptyBuilder(context)
          ],
        ),
      );
    } else {
      child = ListView.separated(
        padding: padding,
        separatorBuilder: (context, index) => SizedBox(height: itemSpacing),
        itemCount: items.length + leadingTiles.length,
        itemBuilder: (context, index) => _buildItem(context, index, items),
      );
    }

    return Expanded(child: child);
  }

  Widget _buildItem(BuildContext context, int index, List<T> items) {
    if (index < leadingTiles.length) {
      return leadingTiles[index];
    }

    return itemBuilder(context, items[index - leadingTiles.length]);
  }
}
