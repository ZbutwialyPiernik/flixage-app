// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    id: json['id'] as String,
    name: json['name'] as String,
    thumbnailUrl: json['thumbnailUrl'] as String,
    streamCount: json['streamCount'] as int,
    fileUrl: json['fileUrl'] as String,
    album: json['album'] == null
        ? null
        : Album.fromJson(json['album'] as Map<String, dynamic>),
    artist: json['artist'] == null
        ? null
        : Artist.fromJson(json['artist'] as Map<String, dynamic>),
    duration: json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int),
    saved: json['saved'] as bool,
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnailUrl': instance.thumbnailUrl,
      'fileUrl': instance.fileUrl,
      'artist': instance.artist,
      'album': instance.album,
      'duration': instance.duration?.inMicroseconds,
      'saved': instance.saved,
      'streamCount': instance.streamCount,
    };
