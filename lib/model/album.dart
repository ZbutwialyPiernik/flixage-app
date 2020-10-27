import 'package:flixage/model/artist.dart';
import 'package:flixage/model/queryable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album extends Queryable {
  final Artist artist;

  Album(
    String id,
    String name,
    String thumbnailUrl,
    this.artist,
  ) : super(id, name, thumbnailUrl);

  @override
  List<Object> get props => [id, name, thumbnailUrl, artist];

  static Album fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
