import 'package:flixage/model/queryable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist extends Queryable {
  final int monthlyListeners;

  Artist({
    String id,
    String name,
    String thumbnailUrl,
    this.monthlyListeners,
  }) : super(id, name, thumbnailUrl);

  static Artist fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);

  @override
  List<Object> get props => [id, name, thumbnailUrl, monthlyListeners];
}
