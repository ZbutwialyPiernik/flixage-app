import 'package:flixage/model/queryable.dart';
import 'package:flutter/material.dart';

class ContextMenuItem<T extends Queryable> extends StatelessWidget {
  final IconData iconData;
  final String description;
  final Function onPressed;

  const ContextMenuItem(
      {Key key,
      @required this.iconData,
      @required this.description,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        FlatButton(
          child: Text(description, style: Theme.of(context).textTheme.subtitle1),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
