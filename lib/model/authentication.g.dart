// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) {
  return Authentication(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    expireTime: json['expireTime'] as int,
  );
}

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expireTime': instance.expireTime,
    };
