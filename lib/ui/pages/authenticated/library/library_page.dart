import 'package:flixage/ui/pages/authenticated/library/playlist_tab.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LibraryPage extends StatelessWidget {
  static const String route = "library";

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Column(
        children: [
          TabBar(
            labelStyle: Theme.of(context).textTheme.headline6,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Colors.white.withOpacity(1),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Playlists'),
              //Tab(text: 'Albums'),
              //Tab(text: 'Artists'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                PlaylistTab(),
                //Text("XDD"),
                //Text("XXXX"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
