// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album(
    json['id'] as String,
    json['name'] as String,
    json['thumbnailUrl'] as String,
    json['artist'] == null
        ? null
        : Artist.fromJson(json['artist'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnailUrl': instance.thumbnailUrl,
      'artist': instance.artist,
    };
