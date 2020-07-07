import 'package:flutter/material.dart';

/// Custom scroll bevahiour removes 'bouncing' of list
class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
