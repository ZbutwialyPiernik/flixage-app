import 'package:flixage/model/artist.dart';
import 'package:flixage/ui/item/item_with_thumbnail.dart';
import 'package:flutter/cupertino.dart';

class ArtistItem extends StatelessWidget {
  final Artist artist;

  const ArtistItem({Key key, this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemWithThumbnail(
      //onTap: ,
      imageUrl: artist.thumbnailUrl,
      details: Text(artist.name),
    );
  }
}
