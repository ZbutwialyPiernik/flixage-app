import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransparentMaterialOverylay extends StatelessWidget {
  final Widget child;

  const TransparentMaterialOverylay({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: (Theme.of(context).bottomAppBarTheme.elevation ?? 8) + 1,
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: child,
      ),
    );
  }
}
