import 'package:flixage/model/queryable.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_item.dart';
import 'package:flutter/material.dart';

abstract class ContextMenu<T extends Queryable> extends StatelessWidget {
  const ContextMenu({
    Key key,
  }) : super(key: key);

  @protected
  List<Widget> createHeader(BuildContext context, T item);

  @protected
  List<ContextMenuItem<T>> createActions(BuildContext context, T item);

  Widget build(BuildContext context) {
    final T item = (ModalRoute.of(context).settings.arguments as Arguments).extra;

    return Material(
      elevation: (Theme.of(context).bottomAppBarTheme.elevation ?? 8) + 1,
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.6),
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
              ...createHeader(context, item),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: createActions(context, item),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
