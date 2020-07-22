import 'package:flixage/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// Simple provider subclass that will handle dispose of bloc
/// to avoid boilerplate dispose() on every provider;
///
/// Also we don't provide context to create function
/// because bloc logic should be decoupled from Flutter SDK
///
/// This class can't be used on blocs that depend on other providers.
/// In this case ProxyProvider should be used
class BlocProvider<T extends Bloc> extends Provider<T> {
  BlocProvider({
    Key key,
    @required T Function(BuildContext context) create,
    Widget child,
    bool lazy,
  }) : super(
          key: key,
          create: create,
          dispose: (_, bloc) => bloc.dispose(),
          child: child,
          lazy: lazy ?? true,
        );
}
