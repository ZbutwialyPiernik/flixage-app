import 'package:dio/dio.dart';
import 'package:flixage/bloc/page/library/top_artists_bloc.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/repository/user_repository.dart';
import 'package:flixage/ui/widget/item/artist_item.dart';
import 'package:flixage/ui/widget/loading_widget.dart';
import 'package:flixage/ui/widget/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtistList extends StatelessWidget {
  final Function(Artist artist) onItemTap;

  const ArtistList({Key key, this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc =
        TopArtistsBloc(userRepository: UserRepository(Provider.of<Dio>(context)));

    return StatefulWrapper(
      onInit: () => bloc.dispatch(LoadArtists()),
      child: Column(
        children: <Widget>[
          StreamBuilder<List<Artist>>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LoadingWidget();
              }

              if (snapshot.data.isEmpty) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text("Nie odsłuchałeś jeszcze żadnego utworu")],
                  ),
                );
              }

              final artists = snapshot.data;

              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: artists.length,
                  itemBuilder: (context, index) => ArtistItem(artist: artists[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
