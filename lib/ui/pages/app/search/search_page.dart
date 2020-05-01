import 'package:flixage/bloc/audio_player_bloc.dart';
import 'package:flixage/bloc/global_bloc.dart';
import 'package:flixage/bloc/search_bloc.dart';
import 'package:flixage/ui/item/track_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = Provider.of<GlobalBloc>(context).searchBloc;
    final AudioPlayerBloc audioPlayerBloc =
        Provider.of<GlobalBloc>(context).audioPlayerBloc;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          SearchField(
              onChanged: (query) => searchBloc.dispatch(TextChanged(query: query))),
          StreamBuilder<SearchState>(
            stream: searchBloc.searchState,
            builder: (context, snapshot) {
              final state = snapshot.data;
              if (state is SearchStateEmpty) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.search, size: 96),
                      Text("Wyszukaj w flixage"),
                      Text("Znajdz ulubioną muzykę i podcasty")
                    ],
                  ),
                );
              } else if (state is SearchStateError) {
                return Expanded(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.error, size: 96),
                        Text("Wystąpił nieznany błąd :("),
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
                print(state.tracks);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        Divider(height: 2, color: Colors.transparent),
                    itemCount: state.tracks.length,
                    itemBuilder: (context, index) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: TrackItem(track: state.tracks[index], height: 48),
                      onTap: () => audioPlayerBloc.dispatch(
                        PlayEvent(audio: state.tracks[index]),
                      ),
                    ),
                  ),
                );
              }

              return Container(width: 0, height: 0);
            },
          )
        ],
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  final Function(String) onChanged;

  SearchField({Key key, this.onChanged}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _focusNode.hasFocus ? EdgeInsets.all(0) : EdgeInsets.all(8),
      child: TextField(
        onChanged: this.widget.onChanged,
        focusNode: _focusNode,
        textAlign: _focusNode.hasFocus ? TextAlign.start : TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
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
    super.dispose();
    _focusNode.dispose();
  }
}
