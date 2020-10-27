import 'package:flixage/model/album.dart';
import 'package:flixage/model/json_converters.dart';
import 'package:flixage/model/queryable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'artist.dart';

part 'track.g.dart';

@JsonSerializable()
@DurationConverter()
class Track extends Queryable {
  final String fileUrl;
  final Artist artist;
  final Album album;
  final Duration duration;
  final bool saved;
  final int streamCount;

  Track({
    String id,
    String name,
    String thumbnailUrl,
    this.streamCount,
    this.fileUrl,
    this.album,
    this.artist,
    this.duration,
    this.saved,
  }) : super(id, name, thumbnailUrl);

  static Track fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  @override
  List<Object> get props =>
      [id, name, thumbnailUrl, album, fileUrl, saved, duration, streamCount];
}
