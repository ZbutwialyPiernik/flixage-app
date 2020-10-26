import 'package:dio/dio.dart';
import 'package:flixage/bloc/search_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/model/playlist.dart';
import 'package:flixage/model/queryable.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/model/user.dart';
import 'package:flixage/repository/search_repository.dart';
import 'package:flixage/ui/widget/item/album_item.dart';
import 'package:flixage/ui/widget/item/artist_item.dart';
import 'package:flixage/ui/widget/item/playlist_item.dart';
import 'package:flixage/ui/widget/item/track_item.dart';
import 'package:flixage/ui/widget/item/user_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const String route = "search";

  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final dio = Provider.of<Dio>(context);
    final searchBloc = SearchBloc(SearchRepository(dio));

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SearchField(
          onChanged: (query) => searchBloc.dispatch(
            TextChanged(
              query: query,
              types: [
                QueryType.Track,
                QueryType.Album,
                QueryType.Artist,
                QueryType.User,
                QueryType.Playlist
              ],
            ),
          ),
        ),
        StreamBuilder<SearchState>(
          stream: searchBloc.state,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state is SearchStateEmpty) {
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search, size: 96),
                    Text(S.current.searchPage_searchInFlixage),
                    Text(S.current.searchPage_findFavouriteMusic),
                  ],
                ),
              );
            } else if (state is SearchStateError) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.error, size: 96),
                      Text(S.current.searchPage_unknownError),
                    ],
                  ),
                ),
              );
            } else if (state is SearchStateLoading) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is SearchStateSuccess) {
              if (state.response.isEmpty) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        S.current.searchPage_notFound(state.query),
                        style:
                            Theme.of(context).textTheme.headline5.copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        S.current.searchPage_tryAgain,
                        style:
                            Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                );
              }

              List<Queryable> items = [
                ...state.response.tracks.items,
                ...state.response.albums.items,
                ...state.response.artists.items,
                ...state.response.users.items,
                ...state.response.albums.items,
              ];

              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var item = items[index];

                    switch (item.runtimeType) {
                      case Track:
                        return TrackItem(track: item, height: 56);
                      case Artist:
                        return ArtistItem(artist: item);
                      case Playlist:
                        return PlaylistItem(playlist: item, height: 56);
                      case Album:
                        return AlbumItem(album: item, height: 56);
                      case User:
                        return UserItem(user: item);
                    }

                    return null;
                  },
                ),
              );
            }

            return Container(width: 0, height: 0);
          },
        )
      ],
    );
  }
}

class SearchField extends StatefulWidget {
  final Function(String) onChanged;

  SearchField({Key key, this.onChanged}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> with SingleTickerProviderStateMixin {
  FocusNode _focusNode = FocusNode();

  AnimationController _controller;
  Animation sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _controller.addListener(() => setState(() {}));
    sizeAnimation = Tween<double>(begin: 8, end: 0).animate(_controller);
    _focusNode.addListener(() {
      _focusNode.hasFocus ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(sizeAnimation.value),
      child: TextField(
        onChanged: this.widget.onChanged,
        focusNode: _focusNode,
        textAlign: _focusNode.hasFocus ? TextAlign.start : TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: S.current.searchPage_search,
          filled: true,
          hintStyle: TextStyle(
              color: _focusNode.hasFocus ? Colors.white.withOpacity(0.5) : Colors.white,
              fontWeight: _focusNode.hasFocus ? FontWeight.normal : FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }
}
