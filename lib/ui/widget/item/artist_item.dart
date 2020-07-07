import 'package:flixage/model/artist.dart';
import 'package:flixage/ui/pages/routes/artist/artist_page.dart';
import 'package:flixage/ui/widget/item/context_menu/artist_context_menu.dart';
import 'package:flixage/ui/widget/item/queryable_item.dart';
import 'package:flutter/cupertino.dart';

class ArtistItem extends StatelessWidget {
  final Artist artist;

  const ArtistItem({Key key, @required this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryableItem(
      item: artist,
      roundedImage: true,
      contextMenuRoute: ArtistContextMenu.route,
      onTap: () => Navigator.pushNamed(context, ArtistPage.route, arguments: artist),
      details: Text(artist.name),
    );
  }
}
