import 'package:flutter/material.dart';

class CachedTab extends StatefulWidget {
  final Widget child;

  const CachedTab({Key key, @required this.child}) : super(key: key);

  @override
  _CachedTabState createState() => _CachedTabState();
}

class _CachedTabState extends State<CachedTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  bool get wantKeepAlive => true;
}
