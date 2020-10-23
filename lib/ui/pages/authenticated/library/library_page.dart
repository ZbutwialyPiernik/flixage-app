import 'package:flixage/ui/pages/authenticated/artist/artist_list.dart';
import 'package:flixage/ui/pages/authenticated/artist/artist_page.dart';
import 'package:flixage/ui/pages/authenticated/playlist/playlist_list.dart';
import 'package:flixage/ui/pages/authenticated/playlist/playlist_page.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/default_network_aware_widget.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LibraryPage extends StatelessWidget {
  static const String route = "library";

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelStyle: Theme.of(context).textTheme.headline6,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Colors.white.withOpacity(1),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Playlists'),
              Tab(text: 'Artists'),
              Tab(text: 'Followed')
              //Tab(text: 'Albums'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                DefaultNetworkAwarePage(
                  child: PlaylistList(
                    onItemTap: (playlist) => Navigator.of(context).pushNamed(
                      PlaylistPage.route,
                      arguments: Arguments(extra: playlist),
                    ),
                  ),
                ),
                DefaultNetworkAwarePage(
                  child: ArtistList(
                    onItemTap: (artist) => Navigator.of(context).pushNamed(
                      ArtistPage.route,
                      arguments: Arguments(extra: artist),
                    ),
                  ),
                ),
                Text("Followed")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
