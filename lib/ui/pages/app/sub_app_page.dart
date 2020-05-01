import 'package:flixage/ui/pages/app/settings_page.dart';
import 'package:flixage/ui/pages/audio_player/audio_player.dart';
import 'package:flixage/ui/pages/playlist/create_playlist_page.dart';
import 'package:flixage/ui/pages/playlist/playlist_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

typedef FutureCallback<T> = Future<T> Function();

class SubAppPage extends StatelessWidget {
  static final Logger logger = Logger();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final routes = {
    PlaylistPage.route: (context) => PlaylistPage(),
    CreatePlaylistPage.route: (context) => CreatePlaylistPage()
  };

  final Widget child;
  final FutureCallback<bool> onWillPop;

  SubAppPage({
    Key key,
    this.child,
    this.onWillPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool hasToPop = onWillPop == null || await onWillPop();

        return hasToPop && !await navigatorKey.currentState.maybePop();
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: "/",
        onGenerateRoute: (settings) {
          final routeBuilder =
              settings.isInitialRoute ? (context) => child : routes[settings.name];

          logger.d("Routing to ${settings.name} with arguments ${settings.arguments})");

          if (routeBuilder == null) {
            logger.e("Unknown route in SubAppPage ${settings.name}");
          }

          return MaterialPageRoute(settings: settings, builder: routeBuilder);
        },
      ),
    );
  }
}
