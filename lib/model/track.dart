import 'package:flixage/model/queryable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'artist.dart';

part 'track.g.dart';

@JsonSerializable()
class Track extends Queryable {
  final String fileUrl;
  final List<Artist> artists;
  final double duration;
  bool saved;
  Track(
      {String id,
      String name,
      String thumbnailUrl,
      this.fileUrl,
      this.artists,
      this.duration,
      this.saved})
      : super(id, name, thumbnailUrl);

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  @override
  List<Object> get props => [id, name, thumbnailUrl, fileUrl, saved, duration];
}
