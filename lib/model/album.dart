import 'package:flixage/model/artist.dart';
import 'package:flixage/model/queryable.dart';
import 'package:flixage/model/track.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album extends Queryable {
  final List<Artist> artists;

  Album(String id, String name, String thumbnailUrl, this.artists)
      : super(id, name, thumbnailUrl);

  @override
  List<Object> get props => [id, name, thumbnailUrl, artists];
}
