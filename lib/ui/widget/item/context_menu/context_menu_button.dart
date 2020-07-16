import 'package:flixage/model/queryable.dart';
import 'package:flixage/ui/pages/authenticated/arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContextMenuButton extends StatelessWidget {
  final String route;
  final Queryable item;

  const ContextMenuButton({Key key, @required this.route, @required this.item})
      : assert(route != null),
        assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.more_vert,
      ),
      onPressed: () => Navigator.of(context).pushNamed(route,
          arguments: Arguments(showBottomAppBar: false, opaque: false, extra: item)),
    );
  }
}
