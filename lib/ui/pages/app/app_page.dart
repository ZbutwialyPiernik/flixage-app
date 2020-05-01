import 'package:flixage/ui/pages/app/home/home_page.dart';
import 'package:flixage/ui/pages/app/library/library_page.dart';
import 'package:flixage/ui/pages/app/search/search_page.dart';
import 'package:flixage/ui/pages/app/sub_app_page.dart';
import 'package:flixage/ui/pages/audio_player/widget/audio_player_widget.dart';
import 'package:flutter/material.dart';

/// Main page of app, user gets redirected here after successful login
class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            SubAppPage(child: HomePage()),
            SubAppPage(child: SearchPage()),
            SubAppPage(child: LibraryPage()),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          AudioPlayerWidget(),
          Divider(
            height: 2,
            color: Theme.of(context).backgroundColor,
          ),
          BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Search")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_music), title: Text("Library"))
            ],
          ),
        ],
      ),
    );
  }
}
