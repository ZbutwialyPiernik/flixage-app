import 'package:dio/dio.dart';
import 'package:flixage/bloc/loading_bloc.dart';
import 'package:flixage/bloc/page/user/user_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/user.dart';
import 'package:flixage/repository/playlist_repository.dart';
import 'package:flixage/ui/widget/arguments.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/default_loading_bloc_widget.dart';
import 'package:flixage/ui/widget/item/context_menu/playlist_context_menu.dart';
import 'package:flixage/ui/widget/item/playlist_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  static const route = '/user';

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CustomImage(
          imageUrl: user.thumbnailUrl,
          width: 128,
          height: 128,
        ),
        Text(user.name),
        DefaultLoadingBlocWidget<UserBloc, UserData>(
          create: (context) =>
              UserBloc(playlistRepository: PlaylistRepository(Provider.of<Dio>(context))),
          onInit: (context, bloc) => bloc.dispatch(Load(arg: user)),
          builder: (context, _, data) {
            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(S.current.userPage_publicPlaylists),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                      itemCount: data.playlists.length,
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemBuilder: (context, index) => PlaylistItem(
                        playlist: data.playlists[index],
                        height: 64,
                        onTap: (playlist) => Navigator.of(context).pushNamed(
                            PlaylistContextMenu.route,
                            arguments: Arguments(extra: playlist, opaque: false)),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
