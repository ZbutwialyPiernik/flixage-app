import 'package:flutter/material.dart';

class MaterialRoute extends StatelessWidget {
  final Widget child;

  const MaterialRoute({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(color: Theme.of(context).backgroundColor, child: child);
  }
}
