import 'package:flixage/model/queryable.dart';
import 'package:flixage/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist extends Queryable {
  final User owner;
  final String shareCode;

  Playlist({
    String id,
    String name,
    String thumbnailUrl,
    this.owner,
    this.shareCode,
  }) : super(id, name, thumbnailUrl);

  static Playlist fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  @override
  List<Object> get props => [id, name, thumbnailUrl, owner, shareCode];
}
