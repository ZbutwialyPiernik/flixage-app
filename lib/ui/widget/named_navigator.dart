import 'package:flutter/material.dart';

class NamedNavigator extends Navigator {
  static const String root = "root";
  static const String nested = "nested";

  final String name;

  const NamedNavigator(
      {Key key,
      @required this.name,
      String initialRoute,
      @required RouteFactory onGenerateRoute,
      RouteFactory onUnknownRoute,
      List<NavigatorObserver> observers = const <NavigatorObserver>[]})
      : assert(onGenerateRoute != null),
        assert(name != null),
        super(
          key: key,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          onUnknownRoute: onUnknownRoute,
          observers: observers,
        );

  static NavigatorState of(BuildContext context, String name) {
    final NavigatorState state = Navigator.of(
      context,
      rootNavigator: name == null,
    );

    var widget = state.widget;

    if (widget is NamedNavigator) {
      if (widget.name == name) {
        return state;
      } else {
        return of(state.context, name);
      }
    } else if (widget != null) {
      return of(state.context, name);
    }

    return state;
  }
}
