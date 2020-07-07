import 'package:flixage/ui/pages/app/home/home_page.dart';
import 'package:flixage/ui/pages/app/library/library_page.dart';
import 'package:flixage/ui/pages/app/search/search_page.dart';
import 'package:flixage/ui/pages/app/settings_page.dart';
import 'package:flixage/ui/pages/routes/artist/artist_page.dart';
import 'package:flixage/ui/pages/routes/playlist/create_playlist_page.dart';
import 'package:flixage/ui/pages/routes/playlist/pick_playlist_page.dart';
import 'package:flixage/ui/pages/routes/playlist/playlist_page.dart';
import 'package:flixage/ui/pages/routes/user/user_page.dart';
import 'package:flixage/ui/widget/named_navigator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//typedef FutureCallback<T> = Future<T> Function();

class SubAppPage extends StatefulWidget {
  static final Logger logger = Logger();

  //final FutureCallback<bool> onWillPop;
  final String initialRoute;

  SubAppPage({
    Key key,
    @required this.initialRoute,
    //this.onWillPop,
  })  : assert(initialRoute != null),
        super(key: key);

  @override
  SubAppPageState createState() => SubAppPageState();
}

class SubAppPageState extends State<SubAppPage> {
  final routes = {
    PlaylistPage.route: (_) => PlaylistPage(),
    CreatePlaylistPage.route: (_) => CreatePlaylistPage(),
    PickPlaylistPage.route: (_) => PickPlaylistPage(),
    UserPage.route: (_) => UserPage(),
    ArtistPage.route: (_) => ArtistPage(),
    SettingsPage.route: (_) => SettingsPage(),
    HomePage.route: (_) => HomePage(),
    SearchPage.route: (_) => SearchPage(),
    LibraryPage.route: (_) => LibraryPage()
  };

  final navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //bool hasToPop = widget.onWillPop == null || await widget.onWillPop();
//hasToPop
        return !await navigator.currentState.maybePop();
      },
      child: Navigator(
        key: navigator,
        //name: NamedNavigator.nested,
        initialRoute: widget.initialRoute,
        onGenerateRoute: (settings) {
          final builder = routes[settings.name];

          if (builder == null) {
            Navigator.of(context).pushNamed(settings.name, arguments: settings.arguments);

            SubAppPage.logger.e("Unknown route in SubAppPage ${settings.name}");

            return null;
          }

          return MaterialPageRoute(
            settings: settings,
            builder: builder,
          );
        },
      ),
    );
  }
}
