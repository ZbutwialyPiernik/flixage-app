import 'package:flixage/ui/pages/app/home/home_page.dart';
import 'package:flixage/ui/pages/app/library/library_page.dart';
import 'package:flixage/ui/pages/app/search/search_page.dart';
import 'package:flixage/ui/pages/app/sub_app_page.dart';
import 'package:flixage/ui/widget/audio_player/audio_player_widget.dart';
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

class LoggedMainPageState extends State<LoggedMainPage> {
  final routes = {0: HomePage.route, 1: SearchPage.route, 2: LibraryPage.route};
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pageKey = GlobalKey<SubAppPageState>();
  final log = Logger();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationRoot(
      scaffoldKey: scaffoldKey,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: SubAppPage(key: pageKey, initialRoute: routes[_currentIndex]),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AudioPlayerWidget(
              navigatorKey: pageKey.currentState.navigator,
            ),
            SizedBox(height: 2),
            BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
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
        ),
      ),
    );
  }
}
