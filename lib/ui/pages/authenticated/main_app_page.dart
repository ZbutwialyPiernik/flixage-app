import 'dart:async';
import 'dart:collection';

import 'package:flixage/ui/pages/authenticated/artist/artist_page.dart';
import 'package:flixage/ui/pages/authenticated/audio_player/audio_player.dart';
import 'package:flixage/ui/pages/authenticated/home/home_page.dart';
import 'package:flixage/ui/pages/authenticated/library/library_page.dart';
import 'package:flixage/ui/pages/authenticated/page_settings.dart';
import 'package:flixage/ui/pages/authenticated/playlist/create_playlist_page.dart';
import 'package:flixage/ui/pages/authenticated/playlist/pick_playlist_page.dart';
import 'package:flixage/ui/pages/authenticated/playlist/playlist_page.dart';
import 'package:flixage/ui/pages/authenticated/search/search_page.dart';
import 'package:flixage/ui/pages/authenticated/settings_page.dart';
import 'package:flixage/ui/pages/authenticated/user/user_page.dart';
import 'package:flixage/ui/widget/audio_player/audio_player_widget.dart';
import 'package:flixage/ui/widget/item/context_menu/album_context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/artist_context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/playlist_context_menu.dart';
import 'package:flixage/ui/widget/item/context_menu/track_context_menu.dart';
import 'package:flixage/ui/widget/notification_root.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// Main page of app, user gets redirected here after successful login
class LoggedMainPage extends StatefulWidget {
  static const route = "/";

  LoggedMainPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoggedMainPageState();
}

class LoggedMainPageState extends State<LoggedMainPage> with NavigatorObserver {
  final Logger logger = Logger();

  final routes = {
    PlaylistPage.route: (_) => PlaylistPage(),
    CreatePlaylistPage.route: (_) => CreatePlaylistPage(),
    PickPlaylistPage.route: (_) => PickPlaylistPage(),
    UserPage.route: (_) => UserPage(),
    ArtistPage.route: (_) => ArtistPage(),
    SettingsPage.route: (_) => SettingsPage(),
    HomePage.route: (_) => HomePage(),
    SearchPage.route: (_) => SearchPage(),
    LibraryPage.route: (_) => LibraryPage(),
    AudioPlayerPage.route: (_) => AudioPlayerPage(),
    AlbumContextMenu.route: (_) => AlbumContextMenu(),
    TrackContextMenu.route: (_) => TrackContextMenu(),
    PlaylistContextMenu.route: (_) => PlaylistContextMenu(),
    ArtistContextMenu.route: (_) => ArtistContextMenu()
  };

  final initialRoutes = {0: HomePage.route, 1: SearchPage.route, 2: LibraryPage.route};
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final log = Logger();

  int _currentIndex = 0;
  StreamController<bool> _showBottomBar;

  @override
  void initState() {
    _showBottomBar = StreamController();
    _currentIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    _showBottomBar.close();
    super.dispose();
  }

  @override
  void didPop(Route route, Route previousRoute) {
    _showBottomBar.add(_determineBottomBarVisibility(previousRoute.settings));
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route previousRoute) {
    _showBottomBar.add(_determineBottomBarVisibility(route.settings));
    super.didPush(route, previousRoute);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationRoot(
      scaffoldKey: scaffoldKey,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async => !await navigator.maybePop(),
            child: Navigator(
              observers: [this],
              initialRoute: initialRoutes[0],
              onGenerateRoute: (settings) {
                return PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => routes[settings.name](context),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 200),
                  settings: settings,
                  opaque: _determineOpaque(settings),
                ); // MaterialPageRoute(
                //settings: settings,
                //builder: builder,
                //);
              },
            ),
          ),
        ),
        bottomNavigationBar: StreamBuilder(
          stream: _showBottomBar.stream,
          builder: (_, snapshot) => (snapshot.data ?? true)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    AudioPlayerWidget(
                      navigator: navigator,
                    ),
                    SizedBox(height: 2),
                    BottomNavigationBar(
                      backgroundColor: Theme.of(context).bottomAppBarColor,
                      currentIndex: _currentIndex,
                      onTap: (index) => setState(() {
                        _currentIndex = index;
                        navigator.pushNamedAndRemoveUntil(
                            initialRoutes[_currentIndex], (route) => false);
                      }),
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          title: Text("Home"),
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.search),
                          title: Text("Search"),
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.library_music),
                          title: Text("Library"),
                        )
                      ],
                    ),
                  ],
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
        ),
      ),
    );
  }

  bool _determineBottomBarVisibility(RouteSettings settings) {
    final arguments = settings.arguments;

    if (arguments is Arguments) {
      return arguments.showBottomAppBar;
    }

    return true;
  }

  bool _determineOpaque(RouteSettings settings) {
    final arguments = settings.arguments;

    if (arguments is Arguments) {
      return arguments.opaque;
    }

    return true;
  }
}
